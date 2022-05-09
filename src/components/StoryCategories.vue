<template>
  <div class="categories-container">
    <h2>{{ header }}</h2>
    <div class="categories">
<!--      <story-button @click="selectCategory('all')" class="all">-->
<!--        All Categories-->
<!--      </story-button>-->
      <story-button v-for="category in categories" :key="category" @click="selectCategory(category)">
        {{ category }}
      </story-button>
      <story-button @click="selectCategory('all')" class="all">
        All Categories
      </story-button>
    </div>
    <p v-if="categorySelected">Selection: {{ categorySelected }}</p>
    <p v-for="story in categoryStories" :key="story">
      {{ story.title }}
    </p>
    <story-footer class="-mx-4 mt-4"></story-footer>
  </div>
</template>

<script>
import StoryFooter from "@/components/StoryFooter";
import StoryButton from "@/components/StoryButton";

export default {
  name: "StoryCategories",
  props: {
    header: String,
    categorySelected: String,
    stories: Object
  },
  components: {
    StoryButton,
    StoryFooter
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
    },
    categoryStories() {
      return !this.categorySelected ? [] : this.stories.filter(story => {
        return story.category && this.categorySelected === story.category.toLowerCase()
      })
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
  @apply capitalize min-h-[6rem] sm:min-h-[12rem] h-full w-full text-lg md:text-2xl
}

.all {
  @apply text-white bg-blue-900 hover:bg-blue-800
}
</style>