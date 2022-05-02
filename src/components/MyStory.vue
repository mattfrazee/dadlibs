<template>
  <div class="story-container">
    <h2>{{ story.title }}</h2>
    <p class="first-letter:uppercase" v-html="content"></p>
    <div class="button-container">
      <button class="retry" type="button" @click="start">Retry</button>
      <button class="finish" type="button" @click="finish">Finish</button>
    </div>
  </div>
</template>

<script>
export default {
  name: "MyStory",
  props: {
    answers: Array,
    story: Object,
  },
  computed: {
    content() {
      let story = this.story.story
      const regexp = /\[([a-z -_][^\]]+)\]/g;
      [...story.matchAll(regexp)].forEach((question, id) => {
        if (this.answers[id]) {
          story = story.replace(question[0], `<span class="highlight">${this.answers[id]}</span>`)
        }
      })
      return story;
    },
  },
  methods: {
    finish() {
      this.$emit('finish-story')
    },
    start() {
      this.$emit('start-story')
    }
  },
}
</script>

<style>
.highlight {
  @apply rounded bg-yellow-300 text-black font-bold underline inline-block px-1 mx-1 transition-all duration-500 ease-in-out scale-100 hover:scale-125
}
</style>

<style scoped>
.story-container {
  @apply min-h-full pt-16 pb-24 px-4 overflow-auto bg-blue-600 overflow-auto text-white;
}

h2 {
  @apply text-5xl font-bold mb-5 mt-8
}

p {
  @apply text-2xl mb-6 leading-10
}

.button-container {
  @apply bg-blue-400 grid grid-cols-2 gap-x-6 p-6 fixed bottom-0 left-0 w-full
}

button {
  @apply bg-blue-300 text-blue-600 block p-4 text-base uppercase rounded-lg font-bold
}

</style>