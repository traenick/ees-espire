class MessageManagerController < ApplicationController
  def index

    @queue_data_response = []
    @new_deq_response = DeqResponse.new

  end

  def pull_from_queue
    que_url = GlobalVariable.find_by_key('DECISION_ENGINE_API_URL').value
    puts que_url
    response = HTTParty.get(que_url)
    @queue_data_response = JSON.parse(response.body).to_json
    respond_to do |format|
      format.js
    end
  end

  def pull_from_local_file
    file_name = GlobalVariable.find_by_key('LOCAL_JSON_SOURCE_FILE_NAME').value
    puts file_name
    @queue_data_response = File.read("./public/" + file_name).squish.to_s
    respond_to do |format|
      format.js
    end
  end

  def parse_queue_data
    @new_deq_response = DeqResponse.new
    @new_deq_response.response_string = params[:queue_data_response]
    if @new_deq_response.save       #grab raw response string and save to QueueResponse table
      @queue_data_response_json = JSON(@new_deq_response.response_string)
      @queue_data_response_json.each do |trans|
        trans['messageArgs'] = arguments_to_json(trans['messageArgs'])
        trans['action']['options'] = trans['action']['options'].split('|')
      end
      @new_deq_response.response_string_as_json = @queue_data_response_json.to_json
      @new_deq_response.save

      @json_to_process = JSON(@new_deq_response.response_string_as_json)
      @json_to_process.each do |trans|
        puts trans
        #check the transaction IDs and see if new message to be added
        if existing_message?(trans['transactionId'])
          puts 'transaction not new : ' + trans['q_transaction_id'].to_s
        else
          # check for new user as originator
          if existing_user?(trans['originatorInfo'])
            puts 'originator user not new'
          else
            create_new_user(trans['originatorInfo'], @new_deq_response.id)
          end
          #collect the processTypeIds of the new transactions to see if message_sub_type need to be created
          if existing_processTypeId?(trans['processTypeId'])
            puts 'processTypeId not new'
          else
            create_new_message_sub_type(trans)
          end
          create_new_message(trans)
        end
        # check for new user as recipient
        if existing_user?(trans['messageArgs']['Recipient'])
          puts 'recipient user not new'
        else
          create_new_user(trans['messageArgs']['Recipient'], @new_deq_response.id)
        end
        # add recipient to message if needed
        if recipient_for_message_exists?(trans)
          puts 'recipient already attached to message'
        else
          add_recipient_to_message(trans)
        end
      end

    end


    respond_to do |format|
      format.js
    end

  end

  def fill_test_email
    @all_users = User.all()
    @all_users.each do |u|
      u.email_address = "traenick+" + u.first_name.gsub(" ", "") + "." + u.last_name.gsub(" ", "") + "@me.com"
      u.save
    end
  end


  private

  def arguments_to_json(arguments)
    arg_array = arguments
    json_hash = {}
    arg_array.each do |pair|
      key = pair['name']
      value = pair['value']
      json_hash[key] = value
    end
    json_hash
  end


  def existing_user?(which_id)
    return !User.find_by_ees_employee_code(which_id).nil?
  end
  def existing_message?(which_id_string)
    !Message.find_by_q_transaction_id(which_id_string).nil?
    #@message = Message.find_by_q_transaction_id(which_id_string)
    #return !@message.nil?
  end
  def existing_processTypeId?(which_id_string)
    return !MessageSubType.find_by_processTypeId(which_id_string).nil?
  end
  def recipient_for_message_exists?(which_trans)
    @which_message = Message.find_by_q_transaction_id(which_trans['transactionId'])
    @which_user = User.find_by_ees_employee_code(which_trans['messageArgs']['Recipient'])
    puts MessageFlow.where(message_id: @which_message.id, user_id: @which_user.id).first
    return !MessageFlow.where(message_id: @which_message.id, user_id: @which_user.id).first.nil?
  end


  def create_new_user(which_ees_emp_code,which_deq_response_id)
    puts "need to create User with ees_employee_code = #{which_ees_emp_code}"
    #employee_info_json = JSON("https://dengine-iis.cloudapp.net/api/employee/id/#{which_ees_emp_code}?type=json")

    # CHECK TO SEE IF CAN CONNECT TO API FIRST?  WHAT IF NOT RESPONSIVE?
    # ALSO SWITCH URL TO GLOBAL VARIABLE

    employee_info_json = HTTParty.get("https://dengine-iis.cloudapp.net/api/employee/id/#{which_ees_emp_code}?type=json").parsed_response
    puts "ees employee service response: " + employee_info_json.to_s
    new_user = User.new
    #get user info from Employee service
    new_user.first_name = employee_info_json['firstName'] ? employee_info_json['firstName'].titleize : which_ees_emp_code
    new_user.last_name = employee_info_json['lastName'] ? employee_info_json['lastName'].titleize : which_ees_emp_code
    new_user.email_address = employee_info_json['emailAddress'] ? employee_info_json['emailAddress'] : which_ees_emp_code

    new_user.api_token = which_ees_emp_code
    new_user.ees_employee_code = which_ees_emp_code
    new_user.deq_response_id = which_deq_response_id
    if new_user.save
      puts new_user
    end
  end
  def create_new_message_sub_type(which_trans)
    puts "need to create MessageSubType with sub_type_name = #{which_trans['processTypeId']} and response_choices = #{which_trans['action']['responseOptions']}"
    new_message_sub_type = MessageSubType.new
    new_message_sub_type.message_type_id = 1
    new_message_sub_type.sub_type_name = which_trans['processTypeId']
    new_message_sub_type.processTypeId = which_trans['processTypeId']
    new_message_sub_type.deq_response_id = which_trans['transactionId']
    if new_message_sub_type.save
      puts 'just created ' + new_message_sub_type.to_s
      #create response_choices
      display_order_count = 1
      which_trans['action']['options'].each do |rc|
        new_rc = new_message_sub_type.response_choices.new
        new_rc.button_title = rc
        new_rc.api_string = rc
        new_rc.button_style = 'tbd'
        new_rc.note_required = false
        new_rc.display_order = display_order_count
        if new_rc.save
          puts 'added response_choice ' + new_rc.to_s
          display_order_count += 1
        end
      end
    end
  end

  def create_new_message(which_trans)
    puts "need to create Message with q_transaction_id = #{which_trans['transactionId']}"
    mst = MessageSubType.find_by_processTypeId(which_trans['processTypeId'])
    puts 'creating message sub type ' + mst.sub_type_name
    new_message = Message.new
    new_message.message_sub_type_id = mst.id
    # add subject
    if which_trans['subject']
      new_message.subject = which_trans['subject']
    else
      puts 'no subject provided, will use MessageSubType name ' + mst.sub_type_name
      new_message.subject = mst.sub_type_name
    end
    # add body
    if which_trans['body']
      new_message.body = which_trans['body']
    else
      puts 'no body provided'
      new_message.body = 'None provided.'
    end
    puts 'subject: ' + new_message.subject
    puts 'body: ' + new_message.body

    new_message.dollar_amt = Integer(Float(which_trans['messageArgs']['TotalAmount'].delete(',')))
    puts "dollar_amt: #{new_message.dollar_amt}"

    orig_user = User.find_by_ees_employee_code(which_trans['originatorInfo'])
    new_message.user_id = orig_user.id
    puts "originator: #{orig_user.first_name} #{orig_user.last_name} #{orig_user.id}"

    new_message.q_transaction_id = which_trans['transactionId']
    puts "q_transaction_id: #{new_message.q_transaction_id}"

    new_message.q_source_id = which_trans['sourceId']
    puts "q_source_id: #{new_message.q_source_id}"

    new_message.q_cost_center_id = which_trans['costCenterId']
    puts "q_cost_center_id: #{new_message.q_cost_center_id}"

    new_message.q_process_type_id = which_trans['processTypeId']
    puts "q_process_type_id: #{new_message.q_process_type_id}"

    new_message.deq_response_id = @new_deq_response.id
    puts "deq_response_id: #{new_message.deq_response_id}"

    if new_message.save
      @message = new_message
      puts "saved new message with id #{@message.id}"
    end

  end

  def add_recipient_to_message(which_trans)
    puts "need to add flow for #{@which_user.first_name} #{@which_user.last_name} to message #{@which_message.id}"
    new_flow = @which_message.message_flows.new
    new_flow.flow_order = which_trans['stateIndex']
    @which_user.message_flows << new_flow
    new_flow.deq_response_id = @new_deq_response.id
  end




end
