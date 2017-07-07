## ----------------------------------------------------------------------------
## Copyright (C) 2017 Verizon.  All Rights Reserved.
##
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
##
##       http://www.apache.org/licenses/LICENSE-2.0
##
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
##
## ----------------------------------------------------------------------------
FROM alpine:3.6

ENV CONSUL_TEMPLATE_VERSION 0.18.1

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /
RUN unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
  mv consul-template /usr/local/bin/consul-template &&\
  rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
  rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64 && \
  mkdir -p /consul-template /consul-template/config.d /consul-template/templates && \
  apk add --update ca-certificates

COPY root.conf /consul-template/config.d

ENTRYPOINT ["/usr/local/bin/consul-template", "-config", "/consul-template/config.d/root.conf"]
