<template>
  <button type="button" :class="{'adult': adult }">
    <span>
      <slot></slot>
      <span v-if="adult" class="block font-normal text-xs opacity-50 italic">(Adult)</span>
    </span>
    <svg v-if="complete" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
      <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="60" d="M416 128L192 384l-96-96"/>
    </svg>
  </button>
</template>

<script>
export default {
  name: "MenuButton",
  props: {
    title: String,
    adult: Boolean,
    complete: Boolean,
  },
}
</script>

<style scoped>
svg {
  @apply fill-current w-6 h-6 text-yellow-300 ml-2
}
button {
  @apply flex justify-between w-full p-4 text-base font-bold text-left leading-6 bg-blue-400 rounded-lg text-blue-900 items-center shadow-lg transition-transform duration-500 ease-in scale-100 hover:scale-125 hover:md:scale-110
}
.adult {
  @apply bg-slate-900 text-white
}
.adult svg {
  @apply text-red-500
}
</style>