class ProfilesController < ApplicationController
    
    
    def new
        #form for user to fill his profile 
        #No other user should be able to access other user profile to edit or fill his profile
        if correct_user
            @user = User.find(params[:user_id])
            @profile = @user.build_profile
        else
           flash[:warning] = "You cannot fill out other people profile"
           redirect_to new_user_profile_path(user_id:current_user.id)
           #render action: :new
        end
    end
    
    def create
        @user = User.find(params[:user_id])
        @profile = @user.build_profile(profile_params)
        if @profile.save
           flash[:success] = "Your profile has been updated successfully"
           redirect_to user_path(params[:user_id]) 
        else
            flash[:danger] = "Error occured while updating profile. Please try again."
            redirect_to new_user_profile_path(params[:user_id])
        end
    end
    
    private
        def profile_params
           params.require(:profile).permit(:first_name, :last_name, :contact_email, :job_title, :phone_number, :description) 
        end
        
        def correct_user
           if current_user.id.to_s == params[:user_id]
               return true
           else
               return false
           end
        end
    
end