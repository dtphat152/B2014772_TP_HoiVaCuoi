<template>
    <div class="container contact-form" style="width: 1000px;">
      <div class="container" style="height: 100px;">
        <!-- Bind change event to handle file selection -->
        <input type="file" id="fileInput" accept="image/*" @change="handleFileChange" style="display: none;">
        <button @click="openFileInput">Upload Image</button>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    name: "Contact",
    data() {
      return {
        selectedFile: null,
      }
    },

    watch: {
        selectedFile :{
            handler: 'uploadImage'
        }
    },

    methods: {
      handleFileChange(event) {
        this.selectedFile = event.target.files[0];
      },
      openFileInput() {
        document.getElementById('fileInput').click();
      },
      async uploadImage() {
        const formData = new FormData();
        formData.append('image', this.selectedFile);
        console.log('selectedFile: ',  this.selectedFile);
        console.log('formData: ',  formData);
        let id = 1;
        try {
          const response = await axios.post(`/uploading/useravt/${id}`, formData, {
            headers: {
              'Content-Type': 'multipart/form-data'
            }
          });
          console.log('Image uploaded successfully:', response.data);
        } catch (error) {
          console.error('Error uploading image:', error);
        }
      }
    }
  }
  </script>

<style>

.contact-form{
    margin-top: 10%;
    margin-bottom: 5%;
    width: 90%;
}
.contact-form .form-control{
    border-radius:1rem;
}
.contact-image{
    text-align: center;
}
.contact-image img{
    border-radius: 6rem;
    width: 11%;
    margin-top: -3%;
    transform: rotate(29deg);
}
.contact-form form{
    padding: 14%;
}
.contact-form form .row{
    margin-bottom: -7%;
}
.contact-form h3{
    margin-bottom: 8%;
    margin-top: -10%;
    text-align: center;
    color: #FF66CC;
}
.contact-form .btnContact {
    width: 50%;
    border: none;
    border-radius: 1rem;
    padding: 1.5%;
    background: #FFF0F5;
    font-weight: 500;
    color: #000000;
    cursor: pointer;
}
.btnContactSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    color: #000000;
    background-color: #FFF0F5;
    border: none;
    cursor: pointer;
}

</style>
