<template>
  <vue-basic-alert :duration="300" :closeIn="4000" ref="alert" />
  <br><br>
  <h1 style="text-align: center; margin-bottom: 0px; color: #ef87aa; font-weight:bold">Ngày Tổ Chức</h1>
  <div class="row d-flex justify-content-center" style="margin-top: 0px;">
    <br>
    <div class="dateinput col-4 borderdate">
      <br>
      <div class="row d-flex justify-content-center">
        <div class="col-5 form-group pt-2 mr-1">
            <label for="startDateInput">Chọn ngày bắt đầu:</label>
            <input type="date" class="form-control" id="startDateInput" v-model="formattedStartDate" @input="validateDateStart">
            <br>
        </div>
        <div class="col-5 form-group pt-2 ml-1">
            <label for="endDateInput">Chọn ngày kết thúc:</label>
            <input type="date" class="form-control" id="endDateInput" v-model="formattedEndDate" @input="validateDateEnd">
            <br>
        </div>
      </div>
      <div class="" style="text-align: center;">
        <button type="button" class="btn font-weight-bold" style="border-color: #FFF0F5; color: #ef87aa;" @click="submitDate">Xác Nhận</button>
      </div>
    </div>
  </div>
  <br><br>
</template>

<script>
import VueBasicAlert from 'vue-basic-alert';
import axios from "axios";
import { mapState } from "vuex";
export default {
  name: "Date",
  data() {
    return {
      selectedDate: { start: null, end: null },
      checkDateStart: true,
      checkDateEnd: true,
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
            return this.selectedDate.start ? this.formatDate(this.selectedDate.start) : null;
          },
          set(value) {
            // Chuyển đổi giá trị ngày từ chuỗi có định dạng "yyyy-MM-dd" sang đối tượng Date
            this.selectedDate.start = value ? new Date(value) : null;
          },
        },

        formattedEndDate: {
          get() {
            // Chuyển đổi giá trị ngày từ đối tượng Date sang chuỗi có định dạng "yyyy-MM-dd"
            return this.selectedDate.end ? this.formatDate(this.selectedDate.end) : null;
          },
          set(value) {
            // Chuyển đổi giá trị ngày từ chuỗi có định dạng "yyyy-MM-dd" sang đối tượng Date
            this.selectedDate.end = value ? new Date(value) : null;
          },
        },
  },

  methods: {
    validateDateStart() {
      if (this.selectedDate.start) {
        const selectedDate = new Date(this.selectedDate.start);
        const tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);

        console.log('Ngày bắt đầu:', selectedDate);
        console.log('Ngày ngày mai:', tomorrow);

        if (selectedDate < tomorrow) {
          this.checkDateStart = false;
          this.$refs.alert.showAlert('warning', 'Sorry!', 'Ngày bắt đầu không hợp lệ!');
        } else {
          this.checkDateStart = true;
        }
      } else {
        this.checkDateStart = false;
      }
    },

    validateDateEnd() {
      const selectedStartDate = new Date(this.selectedDate.start);
      const selectedEndDate = new Date(this.selectedDate.end);
      const tomorrow = new Date();
      tomorrow.setDate(tomorrow.getDate() + 1);

      if (selectedEndDate < tomorrow) {
        this.checkDateEnd = false;
        this.$refs.alert.showAlert('warning', 'Sorry!', 'Ngày kết thúc không hợp lệ!');
      } else if (selectedEndDate < selectedStartDate) {
        this.checkDateEnd = false;
        this.$refs.alert.showAlert('warning', 'Sorry!', 'Ngày kết thúc không được trước ngày bắt đầu!');
      } else {
        this.checkDateEnd = true;
      }
    },

    async getDate() {
      if (this.user) {
        try {
          let existDate = await axios.get('/date/' + this.user.user_id);

          if (existDate.data.length > 0) {
            this.selectedDate.start = new Date(existDate.data[0].date_start);
            this.selectedDate.end = new Date(existDate.data[0].date_end);
            this.validateDateStart();
            this.validateDateEnd();
            console.log('Selected Date:', this.selectedDate);
          } else {
            // Gán giá trị mặc định nếu không có dữ liệu
            this.selectedDate.start = new Date('');
            this.selectedDate.end = new Date('');
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

    async submitDate() {
      if (this.user) {
        let dateSelect = {
          date_start: this.formatDate(this.selectedDate.start),
          date_end: this.formatDate(this.selectedDate.end),
          user_id: parseInt(this.user.user_id),
        };

        try {
          let existDate = await axios.get('/date/' + this.user.user_id);

          if (existDate.data.length > 0) {
            await axios.put("/date", dateSelect);
            this.$refs.alert.showAlert('success', 'Success!', 'The date is changed!');
          } else {
            await axios.post("/date", dateSelect);
            this.$refs.alert.showAlert('success', 'Success!', 'The date is selected!');
          }
        } catch (error) {
          console.error('Error submitting date:', error);
          this.$refs.alert.showAlert('error', 'Error!', 'An error occurred while submitting the date.');
        }
      } else {
        this.$refs.alert.showAlert('warning', 'Sorry!', 'Login now to use this method!');
      }
    },

  },
  components: {
    VueBasicAlert
  }
};
</script>

<style scoped>
.dateinput {
  font-size: larger;
  font-weight: 500;
}

.borderdate{
  border: 5px solid transparent; 
  border-image: linear-gradient(to right, #FFF0F5 0%, #FFF0F5 40%, transparent 40%, transparent 60%, #FFF0F5 60%, #FFF0F5 100%) 2;
}

</style>
