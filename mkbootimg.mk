# Setting device tree image path
ifeq ($(INSTALLED_DTIMAGE_TARGET),)
INSTALLED_DTIMAGE_TARGET := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/arch/$(TARGET_KERNEL_ARCH)/boot/$(BOARD_DT_IMAGE_NAME)
$(INSTALLED_DTIMAGE_TARGET): $(INSTALLED_KERNEL_TARGET)
	$(call pretty,"Target dt image: $@)
	$(call make-kernel-target,$(BOARD_DT_IMAGE_NAME))
endif

# Adding device tree image to the arguments for the mkbootimg command
BOARD_MKBOOTIMG_ARGS += --dtb $(INSTALLED_DTIMAGE_TARGET)

# Generating the boot image
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(INSTALLED_DTIMAGE_TARGET)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE))
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

# Generating the recovery image
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(INSTALLED_DTIMAGE_TARGET) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	$(call pretty,"Target recovery image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE))
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
