<template>
  <div class="row">
    <video :class="classHidden()" ref="camera" autoplay playsinline></video>
    <canvas
      id="photoTaken"
      :hidden="hiddenPhoto"
      :class="classHidden()"
      ref="canvas"
    ></canvas>
  </div>
</template>

<script>
export default {
  props: {
    hiddenPhoto: {
      type: Boolean,
      default: true,
    },
  },
  mounted() {
    this.createCameraElement();
  },
  methods: {
    createCameraElement: function () {
      const constraints = (window.constraints = {
        audio: false,
        video: true,
      });

      navigator.mediaDevices
        .getUserMedia(constraints)
        .then((stream) => {
          this.$refs.camera.srcObject = stream;
        })
        .catch((error) => {
          alert(
            error,
            "Puede que el navegador no sea compatible o que haya algunos errores."
          );
        });
    },
    downloadImage: function () {
      var link = document.createElement("a");
      link.download = "filename.png";
      const canvas = document
        .getElementById("photoTaken")
        .toDataURL("image/jpeg")
        .replace("image/jpeg", "image/octet-stream");
      link.href = canvas;
      link.click();
    },
    takePhoto: function () {
      const context = this.$refs.canvas.getContext("2d");
      const photoFromVideo = this.$refs.camera;
      photoFromVideo.pause();

      context.drawImage(
        photoFromVideo,
        0,
        0,
        this.$refs.canvas.width,
        this.$refs.canvas.height
      );

      const canvas = document.getElementById("photoTaken").toDataURL();

      photoFromVideo.play();
      this.$emit("takePhoto", canvas);
    },
    classHidden: function () {
      return this.hiddenPhoto ? "col-sm-12" : "col-sm-6";
    },
    closeCamera: function() {
        this.$refs.camera.srcObject.getTracks().forEach(function (track) {
          track.stop();
        });
    },
    savePhoto: function(){
      return document.getElementById("photoTaken").toDataURL();
    },
  },
};
</script>
