FROM centos:7
ARG FOREMAN_RELEASE=1.24
ARG KATELLO_RELEASE=3.14

COPY ./foreman-plugins-${FOREMAN_RELEASE}.repo /etc/yum.repos.d/foreman-plugins.repo

RUN yum -y install epel-release && \
	yum -y install centos-release-scl-rh && \
	rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm && \
	yum -y localinstall https://yum.theforeman.org/releases/${FOREMAN_RELEASE}/el7/x86_64/foreman-release.rpm && \
	yum -y localinstall https://fedorapeople.org/groups/katello/releases/yum/${KATELLO_RELEASE}/katello/el7/x86_64/katello-repos-latest.rpm && \
	yum makecache

# Foreman
RUN yum -y install \
	foreman \
	foreman-proxy \
	foreman-debug \
	foreman-ec2 \
	foreman-gce \
	foreman-libvirt \
	foreman-openstack \
	foreman-ovirt \
	foreman-rackspace \
	foreman-vmware \
	foreman-cli \
	foreman-console \
#	foreman-service \
	foreman-selinux \
	foreman-mysql2 \
	foreman-postgresql \
	foreman-sqlite \
	&& yum clean all

# Foreman Plugins
RUN yum -y install \
	tfm-rubygem-foreman_ansible \
	tfm-rubygem-foreman_azure_rm \
	tfm-rubygem-foreman_bootdisk \
	tfm-rubygem-foreman_chef \
	tfm-rubygem-foreman_column_view \
# Fails with a syntax error - custom_parameters
#	tfm-rubygem-foreman_custom_parameters \
	tfm-rubygem-foreman_default_hostgroup \
	tfm-rubygem-foreman_dhcp_browser \
# Complains about missing fog gem
#	tfm-rubygem-foreman_digitalocean \
	tfm-rubygem-foreman_discovery \
	tfm-rubygem-foreman_dlm \
	tfm-rubygem-foreman_docker \
	tfm-rubygem-foreman_expire_hosts \
# needs fog gem
#	tfm-rubygem-foreman_fog_proxmox \
	tfm-rubygem-foreman_git_templates \
	tfm-rubygem-foreman_graphite \
	tfm-rubygem-foreman_hooks \
	tfm-rubygem-foreman_host_extra_validator \
	tfm-rubygem-foreman_inventory_upload \
	tfm-rubygem-foreman_kubevirt \
	tfm-rubygem-foreman_m2 \
	tfm-rubygem-foreman_memcache \
	tfm-rubygem-foreman_monitoring \
	tfm-rubygem-foreman_noenv \
	tfm-rubygem-foreman_omaha \
	tfm-rubygem-foreman_openscap \
	tfm-rubygem-foreman_probing \
	tfm-rubygem-foreman_remote_execution \
	tfm-rubygem-foreman_salt \
	tfm-rubygem-foreman_scc_manager \
	tfm-rubygem-foreman_setup \
	tfm-rubygem-foreman_supervisory_authority \
	tfm-rubygem-foreman_templates \
	tfm-rubygem-foreman_vault \
	tfm-rubygem-foreman_vmwareannotations \
	tfm-rubygem-foreman_wreckingball \
	tfm-rubygem-foreman_xen \
	tfm-rubygem-puppetdb_foreman \
	tfm-rubygem-redhat_access \
	tfm-rubygem-hammer_cli_foreman \
	tfm-rubygem-katello \
	tfm-rubygem-fog-core \
	tfm-rubygem-fog-aws \
	tfm-rubygem-fog-digitalocean \
	tfm-rubygem-fog-proxmox \
	&& yum clean all

# Pulp and Candlepin for Katello are in separate containers.

# Rails complains about apipie cache not being built at startup
RUN foreman-rake apipie:cache


COPY docker-entrypoint.sh /

EXPOSE 3000

USER foreman

CMD /docker-entrypoint.sh

