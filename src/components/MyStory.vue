<template>
  <div class="story-container" :class="{'adult': story.adult}">
    <img
        v-if="story.image"
        :src="story.image"
        :alt="story.title"
        class="story-image">
    <h2>{{ story.title }}</h2>
    <p class="first-letter:uppercase" v-html="content"></p>
    <div class="button-container">
      <story-button @click="start" :adult="story.adult">
        Retry
      </story-button>
      <story-button @click="finish" :adult="story.adult">
        Finish
      </story-button>
    </div>
  </div>
</template>

<script>
import StoryButton from "@/components/StoryButton";

export default {
  name: "MyStory",
  components: {StoryButton},
  props: {
    answers: Array,
    story: Object,
  },
  computed: {
    content() {
      let story = this.story.story
      if (!story) {
        return null
      }
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
  @apply relative rounded bg-yellow-300 text-black font-bold underline inline-block px-1 mx-1 transition-all duration-500 ease-in-out scale-100 hover:scale-125 hover:z-[1] hover:shadow-lg
}

.adult .highlight {
  @apply bg-red-500 text-white
}
</style>

<style scoped>
.story-container {
  @apply min-h-full pt-20 pb-48 px-4 overflow-auto bg-blue-600 overflow-auto text-white z-10
}

.story-container.adult {
  @apply bg-slate-800
}

h2 {
  /*font-family: 'Source Serif Pro';*/
  @apply text-5xl font-bold mb-5 mt-8
}

p {
  /*font-family: 'Overpass';*/
  @apply text-2xl leading-10
}

.story-image {
  @apply object-cover rounded-full mx-auto shadow-lg h-48 w-48 md:h-72 md:w-72 my-4
}

.button-container {
  @apply bg-blue-500 grid grid-cols-2 gap-x-6 p-6 fixed bottom-[4.5rem] left-0 w-full
}

.adult .button-container {
  @apply bg-red-600
}

</style>