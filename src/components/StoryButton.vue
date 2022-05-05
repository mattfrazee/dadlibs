<template>
  <button type="button" :class="{'adult': adult}">
    <slot></slot>
  </button>
</template>

<script>
export default {
  name: "StoryButton",
  props: {
    adult: Boolean
  }
}
</script>

<style scoped>
button {
  @apply w-full sm:w-3/4 md:w-1/2 lg:w-1/4 p-4 text-base font-bold leading-6 bg-blue-400 rounded-lg text-blue-900 shadow-lg hover:bg-blue-300 transition-all duration-500 ease-in
}

button.adult {
  @apply bg-red-500 text-red-900 hover:bg-red-400
}
</style>