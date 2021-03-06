module Users
  class UserSkillRatesController < ApplicationController
    expose_decorated(:user) { User.find_by_id(params[:id]) }
    expose(:skill_categories) { SkillCategory.all }

    def history; end
  end
end
