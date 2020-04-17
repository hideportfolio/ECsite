
class Admin::EndUsersController < Admin::ApplicationController
    def index
      @end_users = EndUser.with_deleted.page(params[:page])
    end


    def show
  	@end_user = EndUser.find(params[:id])
    end

end
