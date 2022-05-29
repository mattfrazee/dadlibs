<template>

  <nav-header
      :stories="sortedStories"
      :story="myStory"
      :answers="myAnswers"
      :toggle="showAdult"
      @start-over="startOver"
      @toggle-adult-menu="showAdult=!showAdult"
      @select-category="selectCategory"></nav-header>

  <story-categories
      header="Select a Category"
      v-if="canShowCategories"
      @select-category="selectCategory"
      :stories="sortedStories"
      :category-selected="selectedCategory"></story-categories>

  <story-menu header="Select a Story" v-if="canShowStoryMenu">
    <template v-for="story in sortedStories" :key="story">
      <menu-button
          v-if="story.title && story.story"
          :adult="story.adult"
          :complete="story.complete"
          class="w-full sm:w-3/4 md:w-1/2 lg:w-1/4"
          @click="selectStory(story)">{{ story.title }}</menu-button>
    </template>
    <menu-button class="go-back"
        v-if="sortedStories.length"
        @click="selectedCategory = null">Go Back</menu-button>
  </story-menu>

  <story-input v-if="myStory && !myStory.complete"
               :story="myStory"
               :questions="questions"
               :answers="myAnswers"
               @back="removeLastAnswer"
               v-on:add-answer="addAnswer"></story-input>

  <my-story v-if="myStory && myStory.complete"
            :story="myStory"
            :answers="myAnswers"
            v-on:finish-story="startOver"
            v-on:start-story="startStory"></my-story>

  <app-footer :adult="showAdult"></app-footer>

</template>

<script>
import MenuButton from "@/components/MenuButton";
import MyStory from "@/components/MyStory";
import NavHeader from '@/components/AppHeader.vue'
import AppFooter from '@/components/AppFooter.vue'
import Speech from "@/components/Speech";
import Dadlibs from "@/components/Dadlibs";
import StoryCategories from "@/components/StoryCategories";
import StoryMenu from "@/components/StoryMenu";
import StoryInput from "@/components/StoryInput";

export default {
  name: 'App',
  components: {
    AppFooter,
    NavHeader,
    MenuButton,
    MyStory,
    StoryCategories,
    StoryInput,
    StoryMenu,
  },
  filters: {
    capitalize: function(text) {
      return text.replace(/(?:^|\s)\S/g, function(a) { return a.toUpperCase(); });
    },
  },
  // beforeMount() {
    // this.myStory = this.stories[0]
  // },
  computed: {
    canShowCategories() {
      return this.selectedCategory === null
    },
    canShowStoryMenu() {
      return !this.myStory && this.selectedCategory !== null
    },
    canShowStoryInput() {
      return this.myStory !== null
          && this.selectedCategory !== null
          && !this.myStory.complete
    },
    questions() {
      const regexp = /\[(.[^\]]+)\]/g
      return [...this.myStory.story.matchAll(regexp)].map( question => {
        return this.parseQuestion(question[1])
      })
    },
    sortedStories() {
      let arr = this.stories
      if (this.selectedCategory && this.selectedCategory !== 'all') {
        arr = arr.filter(story => story.category && story.category.toLowerCase() === this.selectedCategory)
      }
      if (!this.showAdult) {
        arr = arr.filter(story => story.adult !== true)
      }
      return arr.sort((a, b) => a.title.localeCompare(b.title))
    },
    stories() {
      return Dadlibs.stories
    },
  },
  methods: {
    addAnswer(word) {
      if (word !== null) {
        this.myAnswers.push(word)
        this.myStory.complete = this.myAnswers.length === this.questions.length
      }
    },
    removeLastAnswer() {
      this.myAnswers.pop()
    },
    parseQuestion(question) {
      // [speech key | option | label | description | example]
      // examples:
      // [noun|plural]
      // [cat||A Type of Cat]
      // [noun|plural|A Noun|Some description...|Matt, bug, USA, money]
      const arr = question.split('|')
      const id = arr[0]
      const param = arr[1] ? Speech.options.filter(opt => opt.id === arr[1])[0].label : ''
      const type = Speech.types.filter(type => type.id === id)[0] || {}
      return {
        id: id,
        param: arr[1] || null,
        label: this.$options.filters.capitalize(arr[2] || type.label || id),
        paramLabel: param,
        description: arr[3] || type.description || null,
        example: arr[4] || type.example || null,
      }
    },
    selectStory(story) {
      this.myStory = story
      this.myStory.complete = false
    },
    selectCategory(category) {
      this.myStory = null
      this.myAnswers = []
      this.selectedCategory = category || null
    },
    startOver() {
      this.selectCategory()
    },
    startStory() {
      this.myStory.complete = false
      this.myAnswers = []
    },
  },
  data() {
    return {
      myStory: null,
      myAnswers: [],
      selectedCategory: null,
      showAdult: false,
    };
  }
}
</script>

<style scoped>
.go-back {
  @apply justify-center bg-blue-900 hover:bg-blue-800 text-white w-full sm:w-60
}
</style>