<template>
  <footer :class="{'adult':adult}">
    <svg class="stroke-current w-6"
         xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
    </svg>
    <span>
      Dedicated to Ryder
    </span>
  </footer>
</template>

<script>
export default {
  name: "AppFooter",
  props: {
    adult:{
      default: false
    }
  }
}
</script>

<style scoped>
footer {
  @apply text-center text-sm font-bold uppercase text-blue-400 bg-blue-900 flex items-center justify-center space-x-2 py-6 fixed bottom-0 left-0 w-full z-10
}
.adult {
  @apply bg-slate-900 text-white
}
</style>