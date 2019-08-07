<template>
  <div>
    <!-- buttons -->
    <button @click="goToPage(1)"> << </button>

    <button
      @click="goToPage(pagyObj.prev)"
      :disabled="!pagyObj.prev">
      Previous
    </button>

    <input v-model.number="page_num" @change="getPage()">

    <button
      @click="goToPage(pagyObj.next)"
      :disabled="!pagyObj.next">
      Next
    </button>

    <button @click="goToPage(pagyObj.last)"> >> </button>

    <br>

    <ul v-for="post in posts">
      <ul v-for="(value, key) in post">
        <strong>{{ key }} >> </strong>{{ value }}
      </ul>
    </ul>

  </div>
</template>

<script>

  import axios from 'axios'

  export default {

    created(){
      this.getPage()
    },

    data() {
      return {
        page_num: 2, // default starting page
        posts: [],
        pagyObj: {}
      }
    },

    methods: {
      getPage(){
        axios.get(`posts`, {
          params: {
            page: this.page_num
          }
        })
        .then((response) => {
          this.posts = response.data.postsArr
          return response
        })
        .then((response) => {
          this.pagyObj = response.data.pagyData
        })
        .catch((e) => {
          console.log('e', e)
        })
      },
      goToPage(newPageNumber){
        this.page_num = newPageNumber
        this.getPage()
      }
    },

  }

</script>

<style scoped>

</style>