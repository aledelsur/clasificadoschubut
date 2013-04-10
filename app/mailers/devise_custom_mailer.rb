class DeviseCustomMailer < Devise::Mailer
  if self.included_modules.include?(AbstractController::Callbacks)
    raise "You've already included AbstractController::Callbacks, remove this line."
  else
    include AbstractController::Callbacks
  end
 
  before_filter :add_inline_attachment!
 
  def confirmation_instructions(record,opts={})
    super
  end
 
  def reset_password_instructions(record,opts={})
    super
  end
 
  def unlock_instructions(record,opts={})
    super
  end
 
  private
  def add_inline_attachment!
    attachments.inline['ballena.jpg'] = File.read(File.join(Rails.root,'app','assets','images','ballena.jpg'))
  end
end