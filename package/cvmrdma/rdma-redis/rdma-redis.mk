################################################################################
#
# rdma-redis
#
################################################################################

RDMA_REDIS_VERSION = d9423303942b523ce6075791e0d7a55082862039
RDMA_REDIS_SITE = https://github.com/zzaoen/RdmaAcceleratingRedis.git
RDMA_REDIS_SITE_METHOD = git
RDMA_REDIS_DEPENDENCIES = rdma-core-virtual
RDMA_REDIS_INSTALL_STAGING = YES

define RDMA_REDIS_BUILD_CMDS
	cd $(@D)/src/redis && \
	tar -zxvf redis-4.0.11.tar.gz && \
	cd redis-4.0.11/deps/hiredis/ && \
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -j CC="$(TARGET_CC)" LD="$(TARGET_LD)" && \
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) install DESTDIR=$(STAGING_DIR) && \
	cp libhiredis.so $(TARGET_DIR)/usr/lib64 && \
	cp libhiredis.so $(STAGING_DIR)/usr/lib64 && \
	cd $(@D)/src/redis/redis-4.0.11 && \
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -j CC="$(TARGET_CC)" LD="$(TARGET_LD)" && \
	cd $(@D)/src/redis-init && \
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -j CC="$(TARGET_CC)" LD="$(TARGET_CC)" && \
	cd $(@D)/src/rdma/server && \
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -j CC="$(TARGET_CC)" LD="$(TARGET_CC)" && \
	cd $(@D)/src/rdma/client && \
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -j CC="$(TARGET_CC)" LD="$(TARGET_CC)"
endef
# LDFLAGS="-L$(STAGING_DIR)/usr/lib64 ${LDFLAGS} -lhiredis -lrt"

define RDMA_REDIS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/redis/redis-4.0.11/src/redis-server $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/src/redis/redis-4.0.11/src/redis-cli $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/src/redis-init/redis-init $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/src/rdma/server/rdma-server $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/src/rdma/client/rdma-client $(TARGET_DIR)/usr/bin

	mkdir -p $(TARGET_DIR)/root/data
	cp $(@D)/src/redis/redis-4.0.11/redis.conf $(TARGET_DIR)/root/data/redis.conf
endef

$(eval $(generic-package))
