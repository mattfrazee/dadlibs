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
  @apply w-full p-4 text-base font-bold leading-6 bg-blue-400 rounded-lg text-blue-900 shadow-lg
}

button.adult {
  @apply bg-red-500 text-red-900
}
</style>