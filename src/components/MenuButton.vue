<template>
  <story-button class="block mx-auto" :class="{'adult': adult }">
    <span>
      <slot></slot>
      <span v-if="adult" class="block font-normal text-xs opacity-50 italic">(Adult)</span>
    </span>
    <svg v-if="complete" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
      <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="60" d="M416 128L192 384l-96-96"/>
    </svg>
  </story-button>
</template>

<script>
import StoryButton from "@/components/StoryButton";

export default {
  name: "MenuButton",
  components: {StoryButton},
  props: {
    title: String,
    adult: Boolean,
    complete: Boolean,
  },
}
</script>

<style scoped>
button {
  @apply flex justify-between text-left hover:bg-blue-300 transition-all duration-500 ease-in scale-100 hover:scale-110 sm:hover:scale-105
}

button.adult {
  @apply bg-slate-900 text-white hover:bg-slate-800
}

svg {
  @apply fill-current w-6 h-6 text-yellow-300 ml-2
}

.adult svg {
  @apply text-red-500
}
</style>