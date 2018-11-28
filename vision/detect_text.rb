# Copyright 2016 Google, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "uri"

def detect_text image_path:
  # [START vision_text_detection]
  # image_path = "Path to local image file, eg. './image.png'"

  require "google/cloud/vision"

  image_annotator = Google::Cloud::Vision::ImageAnnotator.new

  response = image_annotator.text_detection(
    image: image_path,
    max_results: 1 # optional, defaults to 10
  )

  response.responses.each do |res|
    res.text_annotations.each do |text|
      puts text.description
    end
  end
  # [END vision_text_detection]
end

# This method is a duplicate of the above method, but with a different
# description of the 'image_path' variable, demonstrating the gs://bucket/file
# GCS storage URI format.
def detect_text_gcs image_path:
  # [START vision_text_detection_gcs]
  # image_path = "Google Cloud Storage URI, eg. 'gs://my-bucket/image.png'"

  require "google/cloud/vision"

  image_annotator = Google::Cloud::Vision::ImageAnnotator.new

  response = image_annotator.text_detection(
    image: image_path,
    max_results: 1 # optional, defaults to 10
  )

  response.responses.each do |res|
    res.text_annotations.each do |text|
      puts text.description
    end
  end
  # [END vision_text_detection_gcs]
end

if __FILE__ == $PROGRAM_NAME
  image_path = ARGV.shift

  unless image_path
    return puts <<-USAGE
    Usage: ruby detect_text.rb [image file path]

    Example:
      ruby detect_text.rb image.png
      ruby detect_text.rb https://public-url/image.png
      ruby detect_text.rb gs://my-bucket/image.png
    USAGE
  end
  if image_path =~ URI::DEFAULT_PARSER.make_regexp
    return detect_text_gs image_path: image_path
  end

  detect_text image_path: image_path
end
