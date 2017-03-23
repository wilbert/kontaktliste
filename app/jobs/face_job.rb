# Process faces images when a new message is sent to ENV_face_analyzer queue using AWS SQS service.
class FaceJob < ApplicationJob
  queue_as :face_analyzer

  def perform(*args)
    contact = Contact.find(args[0])

    face_analyzer = FaceAnalyzer.new(contact.avatar.url)
    face_analyzer.call

    if face_analyzer.first_face
      contact.gender = face_analyzer.gender
      contact.face_center_x = face_analyzer.face_center_x
      contact.face_center_y = face_analyzer.face_center_y
      contact.save!
    else
      Rails.logger.info "\n\n\n\n\n\n\n Failed to retrieve face from #{contact.avatar.url}\n\n\n\n\n\n\n"
    end
  rescue RuntimeError
    Rails.logger.error "Failed to process face from #{args[0]}"
  end
end
