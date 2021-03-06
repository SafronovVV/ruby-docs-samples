# Copyright 2017 Google, Inc
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

# [START trace_configure]
require "google/cloud/trace"

Google::Cloud.configure do |config|
  # Stackdriver Trace specific parameters
  config.trace.project_id = "YOUR-PROJECT-ID"
  config.trace.keyfile    = "/path/to/service-account.json"
end
# [END trace_configure]

# [START trace_middleware]
require "google/cloud/trace"

use Google::Cloud::Trace::Middleware
# [END trace_middleware]

run -> (env) { ["200", {"Content-Type" => "text/html"}, ["Hello world!"]] }
