function Pandoc(doc)
  local in_appendix = false
  for _, blk in ipairs(doc.blocks) do
    if blk.t == "Header" then
      if blk.level == 1 and blk.classes:includes("appendix") then
        in_appendix = true
      end
      if in_appendix and blk.level <= 2 then
        blk.attributes["visibility"] = "uncounted"
      end
    end
  end
  return doc
end
