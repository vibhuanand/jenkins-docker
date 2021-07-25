FROM centos

RUN yum -y install openssh-serer 	# Install ssh

RUN useradd remote_user && \		#add user
    echo "remote_user:1234" | chpasswd && \
    mkdir /home/remote/user/.ssh && \
    chmod 700 /home/remote/user/.ssh

COPY remote-key.pub /home/remote_user/.ssh/authorized_key    #copy key to remote_user

RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN /usr/sbin/sshd-keygen

CMD /usr/sbin/sshd -D 	#command to start ssh server
