# How-to-build-Ceph-from-source
A record of the process to build Ceph from source

## Ceph_Installation_Notes(Manually)


1.使用make-j编译时报以下错误，且机器会非常卡顿（google的结果是由于创建线程太多内存不足导致）

        Building CXX object src/rgw/CMakeFiles/rgw_common.dir/rgw_multi.cc.o

        c++: fatal error: Killed signal terminated program cc1plus
        compilation terminated.
        make[2]: *** [src/test/CMakeFiles/unit-main.dir/build.make:76: src/test/CMakeFiles/unit-main.dir/unit.cc.o] Error 1
        make[1]: *** [CMakeFiles/Makefile2:10744: src/test/CMakeFiles/unit-main.dir/all] Error 2
        make[1]: *** Waiting for unfinished jobs....

解决方法：采用make -j 8，但是编译速度慢


2.Install的过程中会报以下错误，但是install结束时也没有其他报错或者任何安装成功的提示。
        
        Error： compiling Cython file: 
        Compile-time name 'BUILD_DOC' not defined


3.ceph -v报以下错误：
        
        ImportError: /usr/local/lib64/python3.6/site-packages/rados.cpython-36m-x86_64-linux-gnu.so: undefined symbol: rados_mgr_command_target

使用ldd命令查看错误原因：
        
        ldd -r rados.cpython-36m-x86_64-linux-gnu.so
        ./rados.cpython-36m-x86_64-linux-gnu.so: /lib64/librados.so.2: no version information available (required by ./rados.cpython-36m-x86_64-linux-gnu.so)
                linux-vdso.so.1 (0x00007fffeac8c000)
                librados.so.2 => /lib64/librados.so.2 (0x00007f1c4ab39000)
                libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f1c4a919000)
                libdl.so.2 => /lib64/libdl.so.2 (0x00007f1c4a715000)
                libutil.so.1 => /lib64/libutil.so.1 (0x00007f1c4a511000)
                libm.so.6 => /lib64/libm.so.6 (0x00007f1c4a18f000)
                libpython3.6m.so.1.0 => /lib64/libpython3.6m.so.1.0 (0x00007f1c49c4c000)
                libc.so.6 => /lib64/libc.so.6 (0x00007f1c49887000)
                libceph-common.so.0 => /usr/lib64/ceph/libceph-common.so.0 (0x00007f1c40b7e000)
                libblkid.so.1 => /lib64/libblkid.so.1 (0x00007f1c4092b000)
                libssl3.so => /lib64/libssl3.so (0x00007f1c406c7000)
                libsmime3.so => /lib64/libsmime3.so (0x00007f1c4049d000)
                libnss3.so => /lib64/libnss3.so (0x00007f1c40162000)
                libnssutil3.so => /lib64/libnssutil3.so (0x00007f1c3ff30000)
                libplds4.so => /lib64/libplds4.so (0x00007f1c3fd2c000)
                libplc4.so => /lib64/libplc4.so (0x00007f1c3fb27000)
                libnspr4.so => /lib64/libnspr4.so (0x00007f1c3f8e6000)
                librt.so.1 => /lib64/librt.so.1 (0x00007f1c3f6de000)
                libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f1c3f4c7000)
                libboost_thread.so.1.66.0 => /lib64/libboost_thread.so.1.66.0 (0x00007f1c3f29b000)
                libboost_system.so.1.66.0 => /lib64/libboost_system.so.1.66.0 (0x00007f1c3f096000)
                libboost_chrono.so.1.66.0 => /lib64/libboost_chrono.so.1.66.0 (0x00007f1c3ee8d000)
                libboost_atomic.so.1.66.0 => /lib64/libboost_atomic.so.1.66.0 (0x00007f1c3ec8b000)
                libboost_random.so.1.66.0 => /lib64/libboost_random.so.1.66.0 (0x00007f1c3ea82000)
                libboost_program_options.so.1.66.0 => /lib64/libboost_program_options.so.1.66.0 (0x00007f1c3e800000)
                libboost_date_time.so.1.66.0 => /lib64/libboost_date_time.so.1.66.0 (0x00007f1c3e5ed000)
                libboost_iostreams.so.1.66.0 => /lib64/libboost_iostreams.so.1.66.0 (0x00007f1c3e3d0000)
                libboost_regex.so.1.66.0 => /lib64/libboost_regex.so.1.66.0 (0x00007f1c3e0b1000)
                libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007f1c3dd1c000)
                libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f1c3db04000)
                /lib64/ld-linux-x86-64.so.2 (0x00007f1c4b1b5000)
                libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007f1c3d61b000)
                libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f1c3d413000)
                libz.so.1 => /lib64/libz.so.1 (0x00007f1c3d1fc000)
                libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f1c3cfeb000)
                libicudata.so.60 => /lib64/libicudata.so.60 (0x00007f1c3b441000)
                libicui18n.so.60 => /lib64/libicui18n.so.60 (0x00007f1c3af80000)
                libicuuc.so.60 => /lib64/libicuuc.so.60 (0x00007f1c3abbe000)
        undefined symbol: rados_mgr_command_target      (./rados.cpython-36m-x86_64-linux-gnu.so)
        undefined symbol: rados_getaddrs        (./rados.cpython-36m-x86_64-linux-gnu.so)
        undefined symbol: rados_unset_pool_full_try     (./rados.cpython-36m-x86_64-linux-gnu.so)
        undefined symbol: rados_set_pool_full_try       (./rados.cpython-36m-x86_64-linux-gnu.so)
        undefined symbol: rados_blocklist_add   (./rados.cpython-36m-x86_64-linux-gnu.so)
        undefined symbol: rados_write_op_omap_rm_range2 (./rados.cpython-36m-x86_64-linux-gnu.so)
        undefined symbol: rados_aio_create_completion2  (./rados.cpython-36m-x86_64-linux-gnu.so)
        undefined symbol: rados_decode_notify_response  (./rados.cpython-36m-x86_64-linux-gnu.so)
        undefined symbol: rados_free_notify_response    (./rados.cpython-36m-x86_64-linux-gnu.so)

解决方法：以上问题是由于librados的路径错误，默认寻找的地址是/lib64/librados.so.2，但是实际上安装时的地址在/usr/local/lib64，我的解决方法是将文件复制过去

4.正常来说安装完ceph会生成/etc/ceph，但是没有，需要手动创建

5.ceph -s报错并且卡住，循环


        ceph -s
        2022-02-12T00:29:42.727+0800 7f5fc6e65700 -1 auth: unable to find a keyring on  /etc/ceph/ceph.client.admin.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin,: (2) No such file or directory
        2022-02-12T00:29:42.727+0800 7f5fc6e65700 -1 AuthRegistry(0x7f5fc005bb50) no keyring found at   /etc/ceph/ceph.client.admin.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin,, disabling cephx
        2022-02-12T00:29:42.729+0800 7f5fc6e65700 -1 auth: unable to find a keyring on /etc/ceph/ceph.client.admin.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin,: (2) No such file or directory
        2022-02-12T00:29:42.729+0800 7f5fc6e65700 -1 AuthRegistry(0x7f5fc00615c0) no keyring found at /etc/ceph/ceph.client.admin.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin,, disabling cephx
        2022-02-12T00:29:42.730+0800 7f5fc6e65700 -1 auth: unable to find a keyring on /etc/ceph/ceph.client.admin.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin,: (2) No such file or directory
        2022-02-12T00:29:42.730+0800 7f5fc6e65700 -1 AuthRegistry(0x7f5fc6e63de0) no keyring found at /etc/ceph/ceph.client.admin.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin,, disabling cephx
        [errno 2] RADOS object not found (error connecting to the cluster)

解决方法：a.修改/etc/ceph/ceph.client.admin.keyring的所有者为sfdev:sfdev（原本为root:root）之后，上述报错没有了，但是仍然会卡住并循环报以下错误

问题：


2022-02-15T18:14:18.360+0800 7f0d965fb700  0 monclient(hunting): authenticate timed out after 300 循环报错



解决方法：需要执行sudo ceph-mon -i mon-node1（mon-node1为hostname）(见第8条)

        [sfdev@mon-node1 ceph]$ ceph -s
          cluster:
            id:     153da071-12a7-420c-9a92-f8982818be5b
            health: HEALTH_WARN
                    mon is allowing insecure global_id reclaim
                    1 monitors have not enabled msgr2

          services:
            mon: 1 daemons, quorum mon-node1 (age 42s)
            mgr: no daemons active
            osd: 0 osds: 0 up, 0 in

          data:
            pools:   0 pools, 0 pgs
            objects: 0 objects, 0 B
            usage:   0 B used, 0 B / 0 B avail
            pgs:
            
            
应该是成功了。


不过仍然有以下错误：


        [sfdev@mon-node1 ceph]$ systemctl status ceph-mon@mon-node1
        ceph-mon@mon-node1.service - Ceph cluster monitor daemon
           Loaded: loaded (/usr/lib/systemd/system/ceph-mon@.service; enabled; vendor preset: disabled)
           Active: failed (Result: exit-code) since Tue 2022-02-15 21:40:14 CST; 24h ago
         Main PID: 662901 (code=exited, status=203/EXEC)

        Feb 15 22:02:30 mon-node1 systemd[1]: ceph-mon@mon-node1.service: Start request repeated too quickly.
        Feb 15 22:02:30 mon-node1 systemd[1]: ceph-mon@mon-node1.service: Failed with result 'exit-code'.
        Feb 15 22:02:30 mon-node1 systemd[1]: Failed to start Ceph cluster monitor daemon.
        Feb 15 22:04:37 mon-node1 systemd[1]: ceph-mon@mon-node1.service: Start request repeated too quickly.
        Feb 15 22:04:37 mon-node1 systemd[1]: ceph-mon@mon-node1.service: Failed with result 'exit-code'.
        Feb 15 22:04:37 mon-node1 systemd[1]: Failed to start Ceph cluster monitor daemon.
        Feb 15 23:06:34 mon-node1 systemd[1]: /usr/lib/systemd/system/ceph-mon@.service:30: Unknown lvalue 'ProtectHostname' in section 'Service'
        Feb 15 23:06:34 mon-node1 systemd[1]: /usr/lib/systemd/system/ceph-mon@.service:31: Unknown lvalue 'ProtectKernelLogs' in section 'Service'
        Feb 15 23:14:30 mon-node1 systemd[1]: /usr/lib/systemd/system/ceph-mon@.service:30: Unknown lvalue 'ProtectHostname' in section 'Service'
        Feb 15 23:14:30 mon-node1 systemd[1]: /usr/lib/systemd/system/ceph-mon@.service:31: Unknown lvalue 'ProtectKernelLogs' in section 'Service'


此问题尚未解决。



6.ceph status 或者 ceph -s

         health: HEALTH_WARN
                    mon is allowing insecure global_id reclaim
                    13 mgr modules have failed dependencies
                    1 monitors have not enabled msgr2
                    OSD count 0 < osd_pool_default_size 1

7.需要将/usr/local/bin下ceph相关文件软链接到/usr/bin  使用脚本文件 运行：

        sudo sh slink.sh /usr/local/bin/ /usr/bin  （脚本文件slink.sh在TestVM@10.67.121.107的home目录下）


最好能够在install的过程中直接install到路径/usr/bin，但是ceph source code包下没有configure文件配置安装路径。

在执行./do_cmake.sh的时候加上参数 -DCMAKE_INSTALL_PREFIX=/usr


8.在ceph -s出现0 monclient(hunting): authenticate timed out after 300的情况下
   执行sudo ceph-mon -i mon-node1后，能够正常运行ceph -s
   
   
        [sfdev@mon-node1 ~]$ ceph -s
          cluster:
            id:     153da071-12a7-420c-9a92-f8982818be5b
            health: HEALTH_WARN
                    mon is allowing insecure global_id reclaim
                    13 mgr modules have failed dependencies
                    1 monitors have not enabled msgr2
                    OSD count 0 < osd_pool_default_size 1

          services:
            mon: 1 daemons, quorum mon-node1 (age 10s)
            mgr: mon-node1(active, since 28m)
            osd: 0 osds: 0 up, 0 in

          data:
            pools:   0 pools, 0 pgs
            objects: 0 objects, 0 B
            usage:   0 B used, 0 B / 0 B avail
            pgs:
  
  但是过一段时间（约1分钟）后再执行ceph -s  mgr daemon会变成inactive状态
  
  
        [sfdev@mon-node1 ~]$ ceph -s
          cluster:
            id:     153da071-12a7-420c-9a92-f8982818be5b
            health: HEALTH_WARN
                    mon is allowing insecure global_id reclaim
                    13 mgr modules have failed dependencies
                    1 monitors have not enabled msgr2
                    OSD count 0 < osd_pool_default_size 1

          services:
            mon: 1 daemons, quorum mon-node1 (age 45s)
            mgr: no daemons active (since 10s)
            osd: 0 osds: 0 up, 0 in

          data:
            pools:   0 pools, 0 pgs
            objects: 0 objects, 0 B
            usage:   0 B used, 0 B / 0 B avail
            pgs:

需要执行ceph-mgr -i mon-node1启动mgr

9.ceph-mon service启动不了

journalctl -xe报以下错误


        Feb 17 19:05:29 monitor1 kubelet[1140]: E0217 19:05:29.196049    1140 kubelet_node_status.go:93] "Unable to register node with API server" err="nodes \"monitor1\" is forbidden: node \"localhost.localdomain\" is not allowed to modify node \"monitor1\"" node="monitor1"
        Feb 17 19:05:31 monitor1 kubelet[1140]: E0217 19:05:31.845480    1140 controller.go:144] failed to ensure lease exists, will retry in 7s, error: leases.coordination.k8s.io "monitor1" is forbidden: User "system:node:localhost.localdomain" cannot get resource "leases" in API group "coordination.k8s.io" in the namesource "leases" in API group "coordination.k8s.io" in the namespace "kube-node-lease": can only access node lease with the same name as the requesting node


## Ceph_Docker_Installation_Notes

1.在install的过程中出现以下问题（手动安装时未出现这个问题）


        Installed /usr/lib/python3.6/site-packages/ceph-1.0.0-py3.6.egg
        Searching for pyyaml
        Reading https://pypi.org/simple/pyyaml/
        Download error on https://pypi.org/simple/pyyaml/: [Errno 99] Cannot assign requested address -- Some packages may not be found!
        Couldn't find index page for 'pyyaml' (maybe misspelled?)



2.ceph -v能够查询安装的版本，但是没有生成image，报错：没有剩余空间
        
        
        -- Installing: /usr/libexec/systemd/system/ceph-radosgw@.service
        -- Installing: /usr/libexec/systemd/system/ceph-rbd-mirror@.service
        -- Installing: /usr/libexec/systemd/system/ceph-immutable-object-cache@.service
        -- Installing: /usr/libexec/systemd/system/cephfs-mirror@.service
        -- Installing: /usr/libexec/systemd/system/rbdmap.service
        -- Installing: /usr/libexec/systemd/system/ceph.target
        -- Installing: /usr/libexec/systemd/system/ceph-fuse.target
        -- Installing: /usr/libexec/systemd/system/ceph-osd.target
        -- Installing: /usr/libexec/systemd/system/ceph-mgr.target
        -- Installing: /usr/libexec/systemd/system/ceph-mon.target
        -- Installing: /usr/libexec/systemd/system/ceph-mds.target
        -- Installing: /usr/libexec/systemd/system/ceph-radosgw.target
        -- Installing: /usr/libexec/systemd/system/ceph-rbd-mirror.target
        -- Installing: /usr/libexec/systemd/system/ceph-immutable-object-cache.target
        -- Installing: /usr/libexec/systemd/system/ceph-volume@.service
        -- Installing: /usr/libexec/systemd/system/cephfs-mirror.target
        ceph version 16.2.7 (dd0603118f56ab514f133c8d2e3adfc983942503) pacific (stable)
        Error processing tar file(exit status 1): write /usr/bin/ceph_test_objectstore: no space left on device










