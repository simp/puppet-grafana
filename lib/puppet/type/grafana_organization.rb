#    Copyright 2015 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
Puppet::Type.newtype(:grafana_organization) do
  @doc = 'Manage organizations in Grafana'

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, namevar: true) do
    desc 'The name of the organization.'
  end

  newparam(:grafana_url) do
    desc 'The URL of the Grafana server'
    defaultto ''

    validate do |value|
      unless value =~ %r{^https?://}
        raise ArgumentError, format('%s is not a valid URL', value)
      end
    end
  end

  newparam(:grafana_user) do
    desc 'The username for the Grafana server'
  end

  newparam(:grafana_password) do
    desc 'The password for the Grafana server'
  end

  newproperty(:id) do
    desc 'The ID of the organization'
  end

  newproperty(:address) do
    desc 'Additional JSON data to configure the organization address (optional)'

    validate do |value|
      unless value.nil? || value.is_a?(Hash)
        raise ArgumentError, 'address should be a Hash!'
      end
    end
  end
  autorequire(:service) do
    'grafana-server'
  end
end
