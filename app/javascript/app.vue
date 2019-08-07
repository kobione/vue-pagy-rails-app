<template>
  <div id="app">
    <somecomponent></somecomponent>
  </div>
</template>

<script>

  import somecomponent from './components/somecomponent.vue'

  export default {
    components: {
      somecomponent,
    }
  }

</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
