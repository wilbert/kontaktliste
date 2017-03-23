require 'kairos'

class FaceAnalyzer
  def initialize(url)
    @url = url
    @client = Kairos::Client.new(app_id: Rails.application.secrets.kairos_app_id, app_key: Rails.application.secrets.kairos_app_key)
  end

  def call
    @response = @client.detect(url: @url, selector: 'FULL')
  end

  def gender
    gender = first_face['attributes']['gender']['type']
    return gender == 'F' ? :female : :male
  rescue
    nil
  end

  def first_face
    @response['images'][0]['faces'][0]
  rescue
    nil
  end

  def face_center_x
    right_eye = first_face['rightEyeCenterX'].to_i
    left_eye = first_face['leftEyeCenterX'].to_i
    (right_eye + left_eye) / 2
  rescue
    nil
  end

  def face_center_y
    right_eye_y = first_face['rightEyeCenterY'].to_i
    chin_y = first_face['chinTipY'].to_i
    (right_eye_y + chin_y) / 2.5
  rescue
    nil
  end
end
