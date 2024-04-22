
<template>

  <br>
  <div class="row d-flex justify-content-center" style="margin-top: 0px;">
    <br>
    <div class="col-8" style="width: 150px;">
      <br>
      <div class="row d-flex justify-content-center">
        <div class="col-7 form-group py-0">
            <label style="width: 100%; padding: 0;" for="startDateInput">
              <h2 class="text-center" style="color: #FF0099; font-weight: 900;">Ngày Tổ Chức Tiệc Cưới</h2>
            </label>
            <input type="date" class="form-control" id="startDateInput" v-model="formattedStartDate"
              style="border: none; text-align: center; background: #ffb3cc; border-radius: 10px; font-weight: 900; font-size: 15px;" >
            <br>
        </div>
      </div>
      <div class="py-0" style="text-align: center;">
        <button type="button" class="btn" style="background-color: #FFC0CB; color: black; border-radius: 10px; font-weight: 900;" 
          @click="submitDate">Xác Nhận
        </button>
      </div>
    </div>
  </div>
  <br><br>
</template>

<script>

import axios from "axios";
import { mapState } from "vuex";
export default {
  name: "Date",
  data() {
    return {
      selectedDate: { date: null },
      checkDate: true,
    };
  },

  created(){
    this.getDate();
  },

  computed: {
        ...mapState(["user"]),

        formattedStartDate: {
          get() {
            // Chuyển đổi giá trị ngày từ đối tượng Date sang chuỗi có định dạng "yyyy-MM-dd"
            return this.selectedDate.date ? this.formatDate(this.selectedDate.date) : null;
          },
          set(value) {
            // Chuyển đổi giá trị ngày từ chuỗi có định dạng "yyyy-MM-dd" sang đối tượng Date
            this.selectedDate.date = value ? new Date(value) : null;
          },
        },
  },

  methods: {


    async getDate() {
      if (this.user) {
        try {
          let existDate = await axios.get('/date/' + this.user.user_id);
          if (existDate.data.length > 0) {
            this.selectedDate.date = new Date(existDate.data[0].date_date);  
          } else {
            // Gán giá trị mặc định nếu không có dữ liệu
            this.selectedDate.date = new Date('');
            console.log('Không có dữ liệu ngày tháng.');
          }
        } catch (error) {
          console.error('Lỗi khi lấy ngày tháng:', error);
        }
      }
    },

    formatDate(date) {
      if (date) {
        const year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();

        month = month < 10 ? `0${month}` : month;
        day = day < 10 ? `0${day}` : day;

        // Trả về chuỗi có định dạng "yyyy-MM-dd"
        return `${year}-${month}-${day}`;
      }

      return null;
    },

    formatDateToSubmit(date) {
      if (date) {
        const year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();

        month = month < 10 ? `0${month}` : month;
        day = day < 10 ? `0${day}` : day;

        // Trả về chuỗi có định dạng "yyyy-MM-dd"
        return `${month}-${day}-${year}`;
      }

      return null;
    },

    async submitDate() {
      if (this.user) {
        let dateSelect = {
          date_date: this.formatDateToSubmit(this.selectedDate.date),
          user_id: parseInt(this.user.user_id),
        };

        try {
          let existDate = await axios.get('/date/' + this.user.user_id);

          if (existDate.data.length > 0) {
            await axios.put("/date", dateSelect);
            // this.$refs.alert.showAlert('success', 'Success!', 'The date is changed!');
            window.confirm(`Ngày Tổ Chức đã được thay đổi!`)
          } else {
            await axios.post("/date", dateSelect);
            // this.$refs.alert.showAlert('success', 'Success!', 'The date is selected!');
            window.confirm(`Ngày Tổ Chức đã được lưu lại!`)
          }
        } catch (error) {
          console.error('Error submitting date:', error);
          // this.$refs.alert.showAlert('error', 'Error!', 'An error occurred while submitting the date.');
          window.confirm(`Lỗi khi xác nhận ngày Tổ chức!`)
        }
      } else {
        // this.$refs.alert.showAlert('warning', 'Sorry!', 'Login now to use this method!');
        window.confirm(`Bạn chưa đăng nhập!`)
      }
    },

  },
  components: {
   
  }
};
</script>