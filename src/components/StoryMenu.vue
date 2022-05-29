<template>
  <div class="menu-container">
    <h2 class="header mt-8 mb-5">{{ header }}</h2>
    <div class="button-container">
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  name: "StoryMenu",
  props: {
    header: String,
  }
}
</script>

<style scoped>
.menu-container {
  @apply min-h-full py-14 overflow-y-auto bg-blue-600 text-white overflow-x-hidden
}

.header {
  @apply text-center text-sm font-bold uppercase text-blue-400
}

.button-container {
  @apply mx-4 mb-8 space-y-4
}
</style>