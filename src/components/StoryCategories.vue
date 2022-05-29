<template>
  <div class="categories-container">
    <h2>{{ header }}</h2>
    <div class="categories">
      <story-button v-for="category in categories" :key="category" @click="selectCategory(category)" class="relative group">
        <span class="relative z-[1]">{{ category }}</span>
<!--        <img src="img/meerkat.jpg" :alt="category" class="object-cover absolute left-0 top-0 w-full h-full rounded-lg opacity-0 group-hover:opacity-25">-->
      </story-button>
      <story-button @click="selectCategory('all')" class="all">
        All Categories
      </story-button>
    </div>
  </div>
</template>

<script>
import StoryButton from "@/components/StoryButton";

export default {
  name: "StoryCategories",
  props: {
    header: String,
    categorySelected: String,
    stories: Object
  },
  components: {
    StoryButton
  },
  computed: {
    categories() {
      let categories = []
      this.stories.filter(story => !!story.category || story.adult).map(story => {
        if (story.adult) {
          story.category = 'adult'
        }
        if (!categories.includes(story.category.toLowerCase())) {
          categories.push(story.category.toLowerCase())
        }
        return story.category
      })
      return categories.sort()
    }
  },
  methods: {
    selectCategory(category) {
      this.$emit('select-category', category)
    }
  }
}
</script>

<style scoped>
.categories-container {
  @apply min-h-full pt-16 pb-24 px-4 overflow-auto bg-blue-600 overflow-auto text-white
}

h2 {
  @apply text-center text-sm font-bold uppercase text-blue-400 mb-5 mt-6
}

.categories {
  @apply grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4 items-center
}

button {
  @apply capitalize min-h-[8rem] sm:min-h-[12rem] h-full w-full text-lg md:text-2xl bg-cover
}

.all {
  @apply text-white bg-blue-900 hover:bg-blue-800
}
</style>