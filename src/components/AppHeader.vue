<template>
  <nav>
    <div class="logo" @click="startOver">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-7 mr-1">
        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
      </svg>
      <span>{{ headerText }}</span>
    </div>
    <div class="flex space-x-4 items-center menu-icons">
      <button type="button" class="nav-menu border-2 rounded-md border-white" @click="toggleMenu">
        <svg v-if="!active" class="menu-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
          <line x1="3" y1="12" x2="21" y2="12"></line>
          <line x1="3" y1="6" x2="21" y2="6"></line>
          <line x1="3" y1="18" x2="21" y2="18"></line>
        </svg>
        <svg v-else xmlns="http://www.w3.org/2000/svg" class="stroke-current stroke-2 w-5" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
      <button type="button" @click="toggleAdultStories" class="hidden">
        <svg class="lock" v-if="!toggle" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
          <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
        </svg>
        <svg class="unlock" v-else xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
          <path d="M7 11V7a5 5 0 0 1 9.9-1"></path>
        </svg>
      </button>
    </div>
  </nav>
  <div :class="{'left-0':active, '-left-full':!active}" class="menu-items">
<!--    <story-button class="mb-4" v-show="story.title" v-for="story in stories" :key="story">-->
<!--      {{ story.title }}-->
<!--    </story-button>-->
    <story-button class="mb-4">
      Main Menu
    </story-button>
    <story-button class="mb-4 capitalize" @click="mainMenu" v-if="story">
      Back to {{ story.category }}
    </story-button>
    <story-button class="mb-4" @click="toggleAdultStories">
      Turn {{ toggle ? 'OFF' : 'ON'}} Adult Content
    </story-button>
  </div>
</template>

<script>
import StoryButton from "@/components/StoryButton";

export default {
  name: 'NavHeader',
  components: {StoryButton},
  emits: ['start-over', 'toggle-adult-menu', 'toggle-menu'],
  props: {
    toggle: Boolean,
    story: Object,
    stories: Array,
    answers: Array,
    headerText: {
      default: 'DadLibs'
    }
  },
  data() {
    return {
      active: false,
    }
  },
  methods: {
    startOver() {
      this.$emit('start-over')
    },
    mainMenu() {
      this.active = !this.active
      this.$emit('start-over')
    },
    toggleAdultStories() {
      this.active = !this.active
      this.$emit('toggle-adult-menu')
    },
    toggleMenu() {
      this.active = !this.active
      this.$emit('toggle-menu', this.active)
    },
  },
}
</script>

<style scoped>
nav {
  @apply text-white fixed w-full top-0 left-0 z-20 flex bg-slate-900 items-center h-16 justify-between px-4
}

.logo {
  font-family: Fjalla One;
  @apply text-4xl text-left pt-2 leading-none flex items-center justify-center cursor-pointer
}

.menu-icons {
  @apply overflow-auto
}

.menu-icons > button {
  @apply w-8 h-8 leading-[0] text-[0px]
}

.menu {
  @apply w-1/2 border-white border-b-2 relative inline-block before:w-full before:border-b-2 before:left-0 before:-top-1.5 before:absolute after:content-['*'] after:w-full after:border-b-2 after:left-0 after:top-1.5 after:absolute
}

.nav-menu {
  @apply text-white border-white
}

button svg {
  @apply stroke-2 stroke-current w-full mx-auto
}

.menu-icon {
  @apply w-5
}

.menu-items {
  @apply fixed pt-16 w-full h-full bg-black bg-opacity-75 text-white pt-20 px-4 z-10 transition-all duration-500 ease-in-out overflow-auto
}

.menu-items > button {
  @apply block mx-auto w-full
}

.lock {
  @apply text-slate-500
}

.unlock {
  @apply text-green-400
}
</style>
