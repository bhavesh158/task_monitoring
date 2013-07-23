class TaskMailer < ActionMailer::Base
  default from: "support@grepruby.com"
  
  def new_task_notification(task, user)
    @task = task
    @user = user
    mail(to: @user.email, subject: 'New task created for you')
  end
end
