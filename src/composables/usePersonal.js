import { ref } from 'vue'
import { supabase } from '../lib/supabaseClient'

const _personal = ref(null)
let _fetched = false

export function usePersonal() {
  async function fetchPersonal() {
    if (_fetched) return
    const { data } = await supabase.from('personal_info').select('*').single()
    if (data) { _personal.value = data; _fetched = true }
  }
  return { personal: _personal, fetchPersonal }
}
