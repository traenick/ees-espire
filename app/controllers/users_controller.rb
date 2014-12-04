class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end


  def load__or_update_all_active_users
    from_db = User.all
    from_service = HTTParty.get("https://dengine-iis.cloudapp.net/api/employee?type=json").parsed_response
    puts "Users in DB: " + from_db.length.to_s
    puts "Employees from Service: " + from_service.length.to_s
    from_service.each do |emp|
      if db_emp = from_db.find {|this_emp| this_emp.ees_employee_code == emp['employeeId'] }
        puts "checking emp:" + db_emp.ees_employee_code + "to see if update needed"
        if db_emp.first_name.to_s != emp['firstName'].to_s || db_emp.last_name.to_s != emp['lastName'].to_s || db_emp.email_address.to_s != emp['email_address'].to_s
          db_emp.first_name = emp['firstName'].to_s.titleize
          db_emp.last_name = emp['lastName'].to_s.titleize
          db_emp.email_address = emp['email_address'].to_s.titleize
          db_emp.save
          puts "updated emp:" + db_emp.ees_employee_code
        else
          puts " emp:" + db_emp.ees_employee_code + " up to date"
        end
      else
        new_user = User.new
        new_user.first_name = emp['firstName'].titleize
        new_user.last_name = emp['lastName'].titleize
        new_user.email_address = emp['emailAddress'].to_s.downcase
        new_user.api_token = emp['employeeId']
        new_user.ees_employee_code = emp['employeeId']
        if new_user.save
          puts "new User created:" + new_user.inspect
        end
      end
    end

    #get user info from Employee service
    #new_user.first_name = employee_info_json['firstName'] ? employee_info_json['firstName'].titleize : which_ees_emp_code
    #new_user.last_name = employee_info_json['lastName'] ? employee_info_json['lastName'].titleize : which_ees_emp_code
    #new_user.email_address = employee_info_json['emailAddress'] ? employee_info_json['emailAddress'] : which_ees_emp_code

    #new_user.api_token = which_ees_emp_code
    #new_user.ees_employee_code = which_ees_emp_code
    #new_user.deq_response_id = which_deq_response_id
    #if new_user.save
      #puts new_user
    #end
  end


end
