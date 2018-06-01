class School < ApplicationRecord

validates :name, presence: true
validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
before_save :format_lat_lng
  def self.filter(params)
    out =[]
    if params[:status].blank?
      out = School.all
    else
      out = School.where(['status = ?', params[:status]])
    end

    return out.order("name ASC")
  end

  private
  def format_lat_lng
    self.latitude = latitude.to_f
    self.longitude = longitude.to_f
  end

  def check_email

  end
end
