#  Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements.  See the NOTICE file distributed with
#   this work for additional information regarding copyright ownership.
#   The ASF licenses this file to You under the Apache License, Version 2.0
#   (the "License"); you may not use this file except in compliance with
#   the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class c3po_java {
  require mysql_client
  require hdfs_client
  require maven
  require c3po_mysqldb

  $path="/bin:/usr/bin"

  # a fuller example, including permissions and ownership
  file { '/home/c3po/codebase':
    ensure => 'directory',
    owner  => 'c3po',
    group  => 'hadoop',
    mode   => '0770',
  }
  ->
  file { '/home/c3po/.m2':
    ensure => 'directory',
    owner  => 'c3po',
    group  => 'hadoop',
    mode   => '0770',
  }
  ->
  file { '/home/c3po/clinical3PO-app-data':
    ensure => 'directory',
    owner  => 'c3po',
    group  => 'hadoop',
    mode   => '0770',
  }
  ->
  file { '/home/c3po/clinical3PO-hadoop-output':
    ensure => 'directory',
    owner  => 'c3po',
    group  => 'hadoop',
    mode   => '0770',
  }
  ->
  file { '/home/c3po/clinical3PO-hadoop-scripts':
    ensure => 'directory',
    owner  => 'c3po',
    group  => 'hadoop',
    mode   => '0770',
  }
  ->
  file { '/home/c3po/clinical3PO-logs':
    ensure => 'directory',
    owner  => 'c3po',
    group  => 'hadoop',
    mode   => '0770',
  }
  ->
  exec { "rmhdfsdatac3pojava":
    path => $path,
    onlyif => "hdfs dfs -test -e /user/c3po/PhysioNet",
    command => "hdfs dfs -rm -skipTrash -r /user/c3po/PhysioNet",
    user => "hdfs",
  }
  ->
  exec { "copyhdfsdatac3pojava":
    path => $path,
    unless => "hdfs dfs -test -e /user/c3po/PhysioNet",
    command => "hdfs dfs -copyFromLocal /vagrant/files/hdfs/PhysioNet /user/c3po/",
    user => "c3po",
  }
  ->
  vcsrepo { '/home/c3po/codebase/Clinical3PO-Platform':
    ensure   => latest,
    provider => git,
    source   => 'https://github.com/Clinical3PO/Platform.git',
    user     => 'c3po',
    owner    => 'c3po',
    group    => 'hadoop',
  }
  ->
  exec { "chmodc3postage":
    path => $path,
    command => "sudo chmod ug+rw /home/c3po/codebase/Clinical3PO-Platform",
  }
  ->
  file { 'sourcemlflex':
    path  => '/home/c3po/ML-Flex',
    ensure  =>  present,
    source  =>  '/home/c3po/codebase/Clinical3PO-Platform/dev/ML-Flex',
    owner     => 'c3po',
    group   =>    'hadoop',
  }
  ->
  exec { "chmodc3pomlflex":
    path => $path,
    command => "sudo chmod ug+rw /home/c3po/ML-Flex",
  }
  ->
  file { "/home/c3po/.m2/settings.xml":
    ensure => file,
    owner => c3po,
    group => 'hadoop',
    mode  => 0770,
    content => template('c3po_java/settingsxml.erb'),
  }
  ->
  file { "/tmp/mvnc3po-java.sh":
    ensure => file,
    owner => c3po,
    group => 'hadoop',
    mode => 0770,
    content => template('c3po_java/mvnc3po-java.erb'),
  }
  ->
  exec { "c3po-java-mvn":
    path => $path,
    command => "/tmp/mvnc3po-java.sh",
    user => "c3po",
  }

}
