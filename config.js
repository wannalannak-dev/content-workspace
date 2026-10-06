/* =========================================================
   ตั้งค่า Content Workspace
   - ถ้าเว้น supabaseUrl / supabaseAnonKey ว่างไว้ = "โหมดทดลอง"
     (ข้อมูลเก็บในเบราว์เซอร์เครื่องเดียว ไม่แชร์กับทีม)
   - ใส่ค่าจาก Supabase > Project Settings > API เพื่อเปิด "โหมดออนไลน์"
     (anon key ใส่ในหน้าเว็บได้ ปลอดภัยเพราะสิทธิ์ถูกคุมด้วย RLS ในฐานข้อมูล)
   ห้ามใส่ service_role key ในไฟล์นี้เด็ดขาด
   ========================================================= */
window.WORKSPACE_CONFIG = {
  supabaseUrl: "https://bdrfaeyztoszimqrdcuj.supabase.co",
  supabaseAnonKey: "sb_publishable_A5aXGj_b2w57rNa7d0byWw_g5Cmqhm_",

  // รายชื่อทีม (คีย์สั้น ๆ : ชื่อที่แสดง + สีวงกลม)
  team: {
    nn: { name: "หนึ่ง", color: "#2F4BD6" },
    pk: { name: "ปุ๊ก",  color: "#0E9F9A" },
    tm: { name: "ต้อม",  color: "#B07A1E" },
    jj: { name: "เจ",    color: "#D6336C" }
  },

  // ช่องทางที่ใช้ลงคอนเทนต์
  channels: {
    instagram: { label: "Instagram", color: "#D6336C" },
    tiktok:    { label: "TikTok",    color: "#0E9F9A" },
    youtube:   { label: "YouTube",   color: "#E03131" },
    facebook:  { label: "Facebook",  color: "#2B6CD4" },
    blog:      { label: "บทความ",    color: "#B07A1E" }
  }
};
