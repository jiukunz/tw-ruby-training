# Email

---

## Protocal

- SMTP: Simple Mail Transfer Protocol, 发邮件用
- POP3: Post Office Protocol 3, 收邮件用
- IMAP: Internet Mail Access Protocol, 收邮件用
- IMAP vs POP3: POP3不能同步客户端状态到服务器，IMAP更加智能好用

---

## Action Mailer

听起来很像Action Controller，**用起来更像!**
---

## Action Mailer Example
```ruby
# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    attachments['file-name.jpg'] = File.read('file-name.jpg').
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end

# app/views/user_mail/welcome_email.text.erb
  Hi, <%= @user.name %> welcome.

# app/controllers/some_controller.rb
  UserMailer.welcome_email(User.first).delivery_now # or delivery_later

```
---

## Attachment / inline attachment
Rails will guess MIME base on file then encode in Base64.
```ruby
# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer

  def welcome_email(user)
    ...
    attachments['file-name.jpg'] = File.read('file-name.jpg')
    # or attachments.inline['file-name.jpg']
    ...
  end
end

```
---
## MIME
Multi-Purpose Internet Mail Extensions, 是一个互联网标准，扩展了邮件标准，支持更多格式的消息, 使用Internet Assigned Numbers Authority管理具体格式类型

```
text/plain（纯文本）
text/html（HTML文档）
application/xhtml+xml（XHTML文档）
image/gif（GIF图像）
image/jpeg（JPEG图像）【PHP中为：image/pjpeg】
image/png（PNG图像）【PHP中为：image/x-png】
video/mpeg（MPEG动画）
application/octet-stream（任意的二进制数据）
application/pdf（PDF文档）
application/msword（Microsoft Word文件）
application/vnd.wap.xhtml+xml (wap1.0+)
application/xhtml+xml (wap2.0+)
message/rfc822（RFC 822形式）
multipart/alternative（HTML邮件的HTML形式和纯文本形式，相同内容使用不同形式表示）
application/x-www-form-urlencoded（使用HTTP的POST方法提交的表单）
multipart/form-data（同上，但主要用于表单提交时伴随文件上传的场合）
```
---
## Multi Email View
```ruby
# app/viwes/user_mailer/welcome.text.erb
# app/viwes/user_mailer/welcome.html.erb
From: xxx
To: xxx
Content-Type: multipart/alternative; boundary=001a113305100c5d0a0516166cca
--001a113305100c5d0a0516166cca # 边界
Content-Type: text/plain; charset=UTF-8 # 纯文本邮件
Hey peeps...
--001a113305100c5d0a0516166cca # 边界
Content-Type: text/html; charset=UTF-8 # HTML邮件
Content-Transfer-Encoding: quoted-printable
<div dir=3D"ltr">...
```
---
## Email With Attachment
```ruby
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5555c219_8f8b73f_f87"
--5555c219_8f8b73f_f87
Content-Type: multipart/alternative; boundary="5555c219_6a37288a_f87" # 纯文本和html邮件正文部分
...
--5555c219_8f8b73f_f87
Content-Type: application/octet-stream # 附件部分
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="IPM 90.pptx"
UEsDBBQAAAAIADGOr0b...
```
---
## TDD with Email
```ruby
class UserMailerTest < ActionMailer::TestCase
  test "invite" do
      # Send the email, then test that it got queued
      email = UserMailer.create_invite('me@example.com',
      'friend@example.com', Time.now).deliver_now
      assert_not ActionMailer::Base.deliveries.empty?

      # Test the body of the sent email contains what we expect it to
      assert_equal ['me@example.com'], email.from
      assert_equal ['friend@example.com'], email.to
      assert_equal 'You have been invited by me@example.com', email.subject
      assert_equal read_fixture('invite').join, email.body.to_s
  end
end
```
---
## Resources
1. [MailCatcher](http://mailcatcher.me/), helps you catch email in development mode
2. [SendGrid](https://sendgrid.com), [Mailgun](http://www.mailgun.com/) as external email service provider
3. [Postfix](http://www.postfix.org/), default Linux email server
---
## receive email
1. Action Mailer can also receive & parse email
2. pull email through POP3 and call mailer method to parse it
3. use external mail server and wait for http callback
---
## sending email is hard
1. do async
2. choose a better service provider
3. control your sending frequency
4. tell user to find email in spam tab
