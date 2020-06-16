home_dir = node['hadoop']['home_dir']

current_instance = search('aws_opsworks_instance','self:true').first
node_name = current_instance['hostname']

if node_name.include?('-nm-1')
  # initialize hadoop hdfs.
  execute 'initialize hadoop hdfs' do
    command "#{home_dir}/bin/hdfs namenode -format"
    user 'hadoop'
    group 'hadoop'
    returns [0]
    action 'run'
    only_if do
      File.exists?home_dir
    end
  end
end