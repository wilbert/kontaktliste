class FaceJob < ApplicationJob
  queue_as :default

  def perform(*args)
    url, id = args

    face_analyzer = FaceAnalyzer.new(url)
    face_analyzer.call

    if face_analyzer.first_face
      contact = Contact.find(id)
      contact.gender = face_analyzer.gender
      contact.face_center_x = face_analyzer.face_center_x
      contact.face_center_y = face_analyzer.face_center_y
      contact.save!
    else
      Rails.logger.info "Failed to retrieve face from #{url}"
    end
  end
end
