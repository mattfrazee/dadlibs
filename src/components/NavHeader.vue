<template>
  <nav>
    <div class="logo" @click="startOver">{{ headerText }}</div>
    <button type="button" @click="toggleMenu">
<!--      <span class="menu"></span>-->
      <svg class="lock" v-if="!toggle" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
      </svg>
      <svg class="unlock" v-else xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
        <path d="M7 11V7a5 5 0 0 1 9.9-1"></path>
      </svg>
    </button>
  </nav>
</template>

<script>
export default {
  name: 'NavHeader',
  props: {
    toggle: Boolean,
    headerText: {
      default: 'DadLibs'
    }
  },
  methods: {
    startOver() {
      this.$emit('start-over')
    },
    toggleMenu() {
      this.$emit('toggle-menu')
    },
  },
}
</script>

<style scoped>
nav {
  @apply text-white fixed w-full top-0 left-0 z-10 flex bg-slate-900 items-center h-16 justify-between px-4
}
.logo {
  font-family: Fjalla One;
  @apply text-4xl text-left pt-2 leading-none flex items-center justify-center cursor-pointer
}
button {
  @apply w-8 h-8 leading-[0] text-[0px]
}
.menu {
  @apply w-1/2 border-white border-b-2 relative inline-block before:w-full before:border-b-2 before:left-0 before:-top-1.5 before:absolute after:content-['*'] after:w-full after:border-b-2 after:left-0 after:top-1.5 after:absolute
}
button svg {
  @apply stroke-current w-full mx-auto
}
.lock {
  @apply text-slate-500
}
.unlock {
  @apply text-green-400
}
</style>
