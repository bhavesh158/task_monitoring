ActionMailer::Base.smtp_settings = {
 :address              => "smtp.gmail.com",
 :port                 => 587,
 :user_name            => "grepruby.taskmonitor@gmail.com",
 :password             => "grepruby123",
 :authentication       => "plain",
 :enable_starttls_auto => true
}
