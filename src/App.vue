<template>

  <nav-header
      :stories="sortedStories"
      :story="myStory"
      :answers="myAnswers"
      header-text="DadLibs"
      @start-over="startOver"
      @toggle-adult-menu="showAdult=!showAdult"
      :toggle="showAdult"></nav-header>

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
               v-on:add-answer="addAnswer"></story-input>

  <my-story v-if="myStory && myStory.complete"
            :story="myStory"
            :answers="myAnswers"
            v-on:finish-story="startOver"
            v-on:start-story="startStory"></my-story>

</template>

<script>
import MenuButton from "@/components/MenuButton";
import MyStory from "@/components/MyStory";
import NavHeader from '@/components/AppHeader.vue'
import Speech from "@/components/Speech";
import Dadlibs from "@/components/Dadlibs";
import StoryCategories from "@/components/StoryCategories";
import StoryMenu from "@/components/StoryMenu";
import StoryInput from "@/components/StoryInput";

export default {
  name: 'App',
  components: {
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
    goto(place) {
      switch (place){
        default:
        case 'home':
          this.startOver()
          break
        case 'select-category':
          this.startOver()
          break
        case 'select-story':
          this.startOver()
          break
        case 'start-story':
          this.startStory()
          break
        case 'view-story':
          this.startOver()
          break
      }
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
      this.selectedCategory = category
    },
    startOver() {
      this.myStory = null
      this.myAnswers = []
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
      // stories: [
      //   {
      //     title: "Looking Forward to Your Death", adult: false,
      //     story: "I was admiring my [female-relative]’s [noun] when she surprised me by [verb|ing], " +
      //         "“When I die, I’m leaving you my [noun] in my will.” I was [emotion], perhaps too much. " +
      //         "“Oh!?” I have never owned a [noun] before. I [verb|past-tense] once before, but not as [adjective] as [relative]’s.",
      //   },
      //   {
      //     title: "Bats, Bats, Bats!", adult: false, category:'animals',
      //     story: "Bats are [adjective] animals which have wings. They like to [verb] around at [time] " +
      //         "which makes some people scared of them. But bats are really [adjective], " +
      //         "and they don't want to hurt people. I have a pet bat that lives in [place]. " +
      //         "I like to feed it [food] and [food]. I am his favorite person, but he also likes [noun]. " +
      //         "I want to convince my [relative] to get me [number] more bat(s).",
      //   },
      //   {
      //     title: 'The American Beaver', adult: false, category:'animals', image: 'img/American_Beaver.jpeg',
      //     story: 'Beavers eat soft [food] when available, but they prefer [noun|plural] found near streams. ' +
      //         'At the Zoo, beavers eat [food], [food], and even [noun|plural]. ' +
      //         'Female beavers are believed to be [adjective] animals. Some think males may [verb] with more than one female. ' +
      //         'The female beaver generally gives birth to [number] kit(s). ' +
      //         'Kits born in the [place] will usually only stay for about [number] year(s) before leading independent adult lives.',
      //   },
      //   {
      //     title: 'The Komodo Dragon', adult: false, category:'animals',
      //     story: 'Komodo dragons are [adjective] predators, because of the [adjective] bacteria in their mouths. ' +
      //         'The Komodo dragon’s [adjective] tail is capable of [verb|ing] a deadly blow to an opponent. ' +
      //         'The Komodo dragon preys on [animal|plural], [animal|plural], and even [animal|plural]. ' +
      //         'Young Komodo dragons eat [animal|plural] found in [place]. Adult males average [number] feet long and weigh [number] pounds. ' +
      //         'Adult females average [number] feet long and weigh about [number] pounds.'
      //   },
      //   {
      //     title: 'It‘s All About the Meerkats', adult: false, category:'animals', image: 'img/meerkat.jpg',
      //     story: 'Meerkats live in the Kalahari desert which is in the southern part of [place]. ' +
      //         'Meerkats are [adjective] animals that live in colonies of up to [number] animal(s).'
      //   },
      //   {
      //     title: 'Fat Guy in a Little Coat', adult: false,
      //     story: 'One [adjective] day I saw a large man in a [adjective] coat. ' +
      //         'He was going to the [place] to buy some [noun|plural]. The man was so [adjective] that the coat barely fit around his [body-part].'
      //   },
      //   {
      //     title: 'The Pokémon Trainer', adult: false, category:'Pokémon',
      //     story: 'Hey, [player name|||A name for the main character.|Jane, Matt, Shadow Walker, jerk], do you think you have what it takes to be a Pokémon trainer? ' +
      //         'Level up your [pokémon character|||The name of a Pokémon character.|Pikachu, Gangar, Charzard, Rowlet] by attacking your opponents [noun]. ' +
      //         'Go to the [place] to find new Pokémon and catch them all. Watch out, your Pokémon has [adjective] and [adjective] all over his [body-part]. ' +
      //         'Defeat your enemies with [noun] attacks but be careful to not let your Pokémon faint or you will have to go to a [place] to heal them. ' +
      //         'The most important thing about catching Pokémon is to have a [adjective] time.'
      //   },
      //   {
      //     title: 'Dog Gone It', adult: true, category:'Adult',
      //     story: '“[cuss-word]!”, [relative] shouted. My mouth was full of [drink] and I couldn’t talk. ' +
      //         'On top of that, [friend], will not stop trying to [verb] my [noun]. I reached over and grabbed my [noun] to stop them. ' +
      //         'But it was too late, my [noun] was gone and all that was left behind was a [adjective] [noun]. '
      //   },
      //   {
      //     title: 'Oh My God', adult: true, category:'Adult',
      //     story: 'I could not believe my eyes, his [body-part] was so big. ' +
      //         'I instantly became [emotion] and I wanted to [verb] him so hard. ' +
      //         'I grabbed his [body-part] and I told him to take me to the [place] and [verb] me. ' +
      //         'I want you to shoot [drink||liquid] all over my [body-part].',
      //   },
      //   {
      //     title: 'Get Well Soon', adult: false, category:'Pokémon',
      //     story: '[player name|||A name for the main character.|Jane, Matt, Shadow Walker, jerk] and [pokémon character|||The name of a Pokémon character.|Pikachu, Gangar, Charzard, Rowlet] were on their way to [place]. ' +
      //         'But something was wrong with the little [adjective] Pokémon. When their ship landed, Ash ran to a [noun]. He called [person] but [person], the assistant, answered. ' +
      //         'Your Pokémon looks terrible, we will be right there. At [time], Professor Birch came speeding up in his car. [exclamation]! We need to get this Pokémon to my lab right away! ' +
      //         'Your Pokémon has too much [noun] and it can’t get rid of it. Soon they reached the lab and saw a [adjective] [noun]. ' +
      //         'This will get rid of the problem he said. But there was still too much [noun]! [exclamation]! The [noun] exploded. ' +
      //         'It blasted a hole in the wall and there was nothing left of [pokémon character|||The name of a Pokémon character.|Pikachu, Gangar, Charzard, Rowlet]'
      //   },
      //   {
      //     title: 'Lorem ipsum dolor sit amet', category:'Development', adult: false,
      //     story: '[Lorem ipsum|plural||Some description about it|lorem, ipsum, dolor, sit] dolor sit amet, consectetur adipisicing elit. Aliquid debitis enim esse ex illum necessitatibus optio rem sed voluptas? Accusantium consequuntur eligendi est inventore laudantium maiores neque nihil, quaerat similique?'
      //   },
      //   {
      //     title: 'Lorem ipsum dolor sit amet 2', category:'Development', adult: true,
      //     story: '[Lorem ipsum|plural||Some description about it|lorem, ipsum, dolor, sit] dolor sit amet, consectetur adipisicing elit. Aliquid debitis enim esse ex illum necessitatibus optio rem sed voluptas? Accusantium consequuntur eligendi est inventore laudantium maiores neque nihil, quaerat similique?'
      //   },
      //   {
      //     title: 'A Day in November', category:'Kids', adult: false,
      //     story: 'It was a [adjective], cold November day. I woke up to the smell of [type of bird|plural||A type or name of a bird.|chicken, oriole, parrot, blue jay] ' +
      //         'roasting in the [room in a house|||A room in a house.|living room, kitchen, bathroom, garage] downstairs. I [verb|past-tense] down the stairs to see if I could help [verb] the food. ' +
      //         'My mom said, “See if [relative] needs a fresh [noun].” So I carried a tray of glasses full of [liquid] into the [verb|ing] room. When I got there, I couldn’t believe my [body-part]! ' +
      //         'There were [noun|plural] [verb|ing] on the [noun]!'
      //   },
      //   {title: '', category:'', story: '', adult: false, image:null},
      //   {title: '', category:'', story: '', adult: false, image:null},
      // ],
    };
  }
}
</script>

<style scoped>
.go-back {
  @apply justify-center bg-blue-900 hover:bg-blue-800 text-white w-full sm:w-60
}
</style>