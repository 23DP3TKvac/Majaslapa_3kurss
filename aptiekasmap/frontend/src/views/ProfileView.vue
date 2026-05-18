<template>
  <v-container class="py-12" v-if="user">
    <v-row justify="center">
      <v-col cols="12" md="8">

        <!-- Profile card -->
        <v-card rounded="xl" elevation="3" class="mb-6">
          <v-card-item>
            <template #prepend>
              <v-avatar color="primary" size="64">
                <span class="text-h5 text-white font-weight-bold">
                  {{ user.name[0].toUpperCase() }}
                </span>
              </v-avatar>
            </template>
            <v-card-title class="text-h5">{{ user.name }}</v-card-title>
            <v-card-subtitle>{{ user.email }}</v-card-subtitle>
            <template #append>
              <v-chip :color="roleColor" variant="tonal" size="small">
                {{ roleLabel }}
              </v-chip>
            </template>
          </v-card-item>
          <v-card-actions class="px-6 pb-4">
            <v-btn color="error" variant="outlined" rounded="lg" @click="logout">
              <v-icon start>mdi-logout</v-icon>
              Iziet
            </v-btn>
          </v-card-actions>
        </v-card>

        <!-- Medicine Sets -->
        <v-card rounded="xl" elevation="3" class="mb-6">
          <v-card-title class="pa-6 pb-2 d-flex align-center justify-space-between">
            <span><v-icon color="primary" class="mr-2">mdi-package-variant</v-icon>Mani komplekti</span>
            <v-btn color="primary" size="small" variant="tonal" rounded="lg" @click="createSetDialog = true">
              <v-icon start>mdi-plus</v-icon> Jauns komplekts
            </v-btn>
          </v-card-title>
          <v-card-text>
            <div v-if="setsLoading" class="text-center py-4">
              <v-progress-circular color="primary" indeterminate />
            </div>
            <div v-else-if="sets.length === 0" class="text-center py-6 text-medium-emphasis">
              <v-icon size="48">mdi-package-variant-closed</v-icon>
              <p class="mt-2">Nav izveidotu komplektu</p>
            </div>
            <div v-else>
              <v-expansion-panels>
                <v-expansion-panel v-for="set in sets" :key="set.id" rounded="lg" class="mb-2">
                  <v-expansion-panel-title>
                    <div class="d-flex align-center justify-space-between w-100 mr-2">
                      <span class="font-weight-bold">{{ set.name }}</span>
                      <v-chip size="x-small" color="primary" variant="tonal">
                        {{ set.medicines.length }} zāles
                      </v-chip>
                    </div>
                  </v-expansion-panel-title>
                  <v-expansion-panel-text>
                    <p v-if="set.description" class="text-medium-emphasis text-body-2 mb-3">{{ set.description }}</p>
                    <v-chip v-for="med in set.medicines" :key="med.id" class="mr-2 mb-2" color="primary" variant="tonal" size="small">
                      {{ med.name }}
                      <v-icon end size="14" @click="removeMedFromSet(set.id, med.id)">mdi-close</v-icon>
                    </v-chip>
                    <div class="mt-3 d-flex gap-2">
                      <v-btn size="small" color="error" variant="outlined" rounded="lg" @click="deleteSet(set.id)">
                        <v-icon start>mdi-delete</v-icon> Dzēst komplektu
                      </v-btn>
                    </div>
                  </v-expansion-panel-text>
                </v-expansion-panel>
              </v-expansion-panels>
            </div>
          </v-card-text>
        </v-card>

        <!-- Create Set Dialog -->
        <v-dialog v-model="createSetDialog" max-width="400">
          <v-card rounded="xl" class="pa-2">
            <v-card-title class="pt-4 px-6">Jauns komplekts</v-card-title>
            <v-card-text class="px-6">
              <v-text-field v-model="newSet.name" label="Nosaukums *" variant="outlined" class="mb-3" />
              <v-text-field v-model="newSet.description" label="Apraksts" variant="outlined" />
            </v-card-text>
            <v-card-actions class="px-6 pb-4">
              <v-spacer />
              <v-btn variant="text" @click="createSetDialog = false">Atcelt</v-btn>
              <v-btn color="primary" variant="flat" rounded="lg" @click="createSet">Izveidot</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>

        <!-- Favorites -->
        <v-card rounded="xl" elevation="3" class="mb-6">
          <v-card-title class="pa-6 pb-2">
            <v-icon color="error" class="mr-2">mdi-heart</v-icon>
            Favorīti
          </v-card-title>
          <v-card-text>
            <div v-if="favLoading" class="text-center py-4">
              <v-progress-circular color="primary" indeterminate />
            </div>
            <v-row v-else-if="favorites.length > 0">
              <v-col v-for="med in favorites" :key="med.id" cols="12" sm="6">
                <v-card rounded="xl" variant="tonal" color="primary">
                  <v-card-item>
                    <template #prepend>
                      <v-icon color="primary">mdi-pill</v-icon>
                    </template>
                    <v-card-title class="text-body-2 font-weight-bold">{{ med.name }}</v-card-title>
                    <v-card-subtitle>{{ med.form }} · {{ med.dose }}</v-card-subtitle>
                    <template #append>
                      <v-btn icon size="small" variant="text" color="error"
                        @click="removeFavorite(med.id)">
                        <v-icon>mdi-heart-off</v-icon>
                      </v-btn>
                    </template>
                  </v-card-item>
                </v-card>
              </v-col>
            </v-row>
            <div v-else class="text-center py-6 text-medium-emphasis">
              <v-icon size="48">mdi-heart-outline</v-icon>
              <p class="mt-2">Favorītu saraksts ir tukšs</p>
            </div>
          </v-card-text>
        </v-card>

        <!-- Search history -->
        <v-card rounded="xl" elevation="3" class="mb-6">
          <v-card-title class="pa-6 pb-2">
            <v-icon color="primary" class="mr-2">mdi-history</v-icon>
            Meklēšanas vēsture
          </v-card-title>
          <v-card-text>
            <div v-if="historyLoading" class="text-center py-4">
              <v-progress-circular color="primary" indeterminate />
            </div>
            <v-list v-else-if="history.length > 0">
              <v-list-item v-for="h in history" :key="h.id"
                           :subtitle="formatDate(h.created_at)"
                           :title="h.medicine_name"
                           prepend-icon="mdi-magnify">
                <template #append>
                  <v-btn size="small" variant="tonal" color="primary"
                         @click="searchMedicine(h.medicine_name)">
                    Meklēt vēlreiz
                  </v-btn>
                </template>
              </v-list-item>
            </v-list>
            <div v-else class="text-center py-6 text-medium-emphasis">
              <v-icon size="48">mdi-history</v-icon>
              <p class="mt-2">Meklēšanas vēsture ir tukša</p>
            </div>
          </v-card-text>
        </v-card>

        <!-- Notifications -->
        <v-card rounded="xl" elevation="3">
          <v-card-title class="pa-6 pb-2">
            <v-icon color="primary" class="mr-2">mdi-bell</v-icon>
            Paziņojumi
            <v-chip v-if="unreadCount > 0" color="error" size="x-small" class="ml-2">
              {{ unreadCount }}
            </v-chip>
          </v-card-title>
          <v-card-text>
            <div v-if="notifLoading" class="text-center py-4">
              <v-progress-circular color="primary" indeterminate />
            </div>
            <v-list v-else-if="notifications.length > 0">
              <v-list-item v-for="n in notifications" :key="n.id"
                           :title="n.message"
                           :subtitle="formatDate(n.created_at)"
                           prepend-icon="mdi-bell-outline"
                           :class="n.is_read === 'not_read' ? 'bg-primary-lighten' : ''">
                <template #append>
                  <v-btn v-if="n.is_read === 'not_read'" size="small"
                         variant="text" color="primary"
                         @click="markRead(n.id)">
                    Atzīmēt kā lasītu
                  </v-btn>
                  <v-icon v-else color="success">mdi-check</v-icon>
                </template>
              </v-list-item>
            </v-list>
            <div v-else class="text-center py-6 text-medium-emphasis">
              <v-icon size="48">mdi-bell-off</v-icon>
              <p class="mt-2">Paziņojumu nav</p>
            </div>
          </v-card-text>
        </v-card>

      </v-col>
    </v-row>
  </v-container>

  <!-- Not logged in -->
  <v-container v-else class="py-12 text-center">
    <v-icon size="80" color="medium-emphasis">mdi-account-off</v-icon>
    <h2 class="text-h5 mt-4 mb-2">Tu neesi pieslēdzies</h2>
    <p class="text-medium-emphasis mb-6">Lūdzu pieslēdzies vai reģistrējies</p>
    <v-btn color="primary" size="large" rounded="lg" to="/">
      Doties uz sākumu
    </v-btn>
  </v-container>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import axios from 'axios'

const auth = useAuthStore()
const router  = useRouter()
const user    = ref(null)
const history = ref([])
const notifications = ref([])
const historyLoading = ref(true)
const notifLoading   = ref(true)
const favorites  = ref([])
const favLoading = ref(true)
const sets           = ref([])
const setsLoading    = ref(true)
const createSetDialog = ref(false)
const newSet         = ref({ name: '', description: '' })

async function loadSets() {
  try {
    const { data } = await axios.get('/api/user/sets')
    sets.value = data
  } catch {} finally {
    setsLoading.value = false
  }
}

async function createSet() {
  if (!newSet.value.name) return
  try {
    const { data } = await axios.post('/api/user/sets', newSet.value)
    sets.value.push({ ...data, medicines: [] })
    createSetDialog.value = false
    newSet.value = { name: '', description: '' }
  } catch {}
}

async function deleteSet(setId) {
  try {
    await axios.delete(`/api/user/sets/${setId}`)
    sets.value = sets.value.filter(s => s.id !== setId)
  } catch {}
}

async function removeMedFromSet(setId, medicineId) {
  try {
    const { data } = await axios.delete(`/api/user/sets/${setId}/medicines/${medicineId}`)
    const set = sets.value.find(s => s.id === setId)
    if (set) set.medicines = data.medicines
  } catch {}
}

async function removeFavorite(medicineId) {
  try {
    await axios.delete(`/api/user/favorites/${medicineId}`)
    favorites.value = favorites.value.filter(f => f.id !== medicineId)
  } catch {}
}

const roleLabel = computed(() => {
  const roles = { admin: 'Administrators', pharmacy_rep: 'Aptieka', user: 'Lietotājs' }
  return roles[user.value?.role] || 'Lietotājs'
})
const roleColor = computed(() => {
  const colors = { admin: 'error', pharmacy_rep: 'warning', user: 'success' }
  return colors[user.value?.role] || 'success'
})
const unreadCount = computed(() =>
  notifications.value.filter(n => n.is_read === 'not_read').length
)

function formatDate(dateStr) {
  return new Date(dateStr).toLocaleString('lv-LV')
}

function searchMedicine(name) {
  router.push({ path: '/', query: { search: name } })
}

async function logout() {
  try {
    await axios.post('/api/auth/logout')
  } catch {}
  auth.logout()
  router.push('/')
}

async function markRead(id) {
  try {
    await axios.patch(`/api/user/notifications/${id}/read`)
    const n = notifications.value.find(n => n.id === id)
    if (n) n.is_read = 'read'
  } catch {}
}

onMounted(async () => {
  const token = localStorage.getItem('token')
  if (!token) return

  try {
    const { data } = await axios.get('/api/user')
    user.value = data
  } catch {
    localStorage.removeItem('token')
    return
  }

  try {
    const { data } = await axios.get('/api/user/history')
    history.value = data
  } catch {} finally {
    historyLoading.value = false
  }

  try {
    const { data } = await axios.get('/api/user/notifications')
    notifications.value = data
  } catch {} finally {
    notifLoading.value = false
  }

  try {
    const { data } = await axios.get('/api/user/favorites')
    favorites.value = data
  } catch {} finally {
    favLoading.value = false
  }
  
  loadSets()
})
</script>
