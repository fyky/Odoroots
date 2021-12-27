require "#{Rails.root}/app/models/event"

class Tasks::Eventupdatetask
  def self.recruitment_end
    # if Date.current > Event.published.deadline
    Event.published.where(['deadline < ?', Date.current]).update_all(recruitment: false)
    # end
  end

end