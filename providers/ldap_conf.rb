#
# Cookbook:: openvpn
# Provider:: conf
#
# Copyright:: 2013, Tacit Knowledge, Inc.
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

use_inline_resources

action :create do
  # FreeBSD service uses openvpn.conf
  template_source = 'ldap.conf.erb'

  template [node['openvpn']['fs_prefix'], "/etc/openvpn/ldap.conf"].join do
    cookbook new_resource.cookbook
    source template_source
    owner 'root'
    group node['openvpn']['root_group']
    mode '644'
    variables(
      ldap: new_resource.ldap || node['openvpn']['ldap_auth']['ldap'],
      authorization: new_resource.authorization || node['openvpn']['ldap_auth']['authorization'],
      authorization_group: new_resource.authorization || node['openvpn']['ldap_auth']['authorization']['group']
    )
  end
end

action :delete do
  file [node['openvpn']['fs_prefix'], "/etc/openvpn/ldap.name}.conf"].join do
    action :delete
  end
end
