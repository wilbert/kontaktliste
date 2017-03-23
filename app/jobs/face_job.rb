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
      Rails.logger.info "Failed to retrieve face from #{contact.avatar.url}"
    end
  end
end
