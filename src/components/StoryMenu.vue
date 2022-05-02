<template>
  <div class="menu-container">
    <h2 class="header mt-8 mb-6">{{ header }}</h2>
    <div class="button-container">
      <slot></slot>
    </div>
    <p class="bg-blue-900 header mt-6 flex items-center justify-center space-x-2 py-6">
      <svg class="stroke-current w-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
      </svg>
      <span>
        Dedicated to Ryder
      </span>
    </p>
  </div>
</template>

<script>
export default {
  name: "StoryMenu",
  props: {
    header: String,
  },
}
</script>

<style scoped>
.menu-container {
  @apply min-h-full pt-14 overflow-y-auto bg-blue-600 text-white overflow-x-hidden
}

.header {
  @apply text-center text-sm font-bold uppercase text-blue-400
}

.button-container {
  @apply mx-8 mb-8 space-y-4
}
</style>