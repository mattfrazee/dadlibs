<template>
  <nav class="fixed w-full top-0 left-0">
    <div class="my-logo">{{ headerText }}</div>
  </nav>
</template>

<script>
export default {
  name: 'NavHeader',
  props: {
    headerText: {
      default: 'DadLibs'
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="postcss">
.my-logo {
  @apply text-white text-2xl text-center bg-gray-900 px-3 pb-2 pt-3 leading-none;
}
</style>
