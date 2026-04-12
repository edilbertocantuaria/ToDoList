import { useEffect, useMemo, useState } from "react";
import { Box, MenuItem, Select, Typography } from "@mui/material";

export default function TagFilter({ myTags = [], onTagFilterChange }) {
  const [selectedTag, setSelectedTag] = useState("all");

  const sortedTags = useMemo(() => {
    return [...myTags].sort((a, b) => a.tagName.localeCompare(b.tagName));
  }, [myTags]);

  function handleTagFilterChange(event) {
    const selectedValue = event.target.value;
    setSelectedTag(selectedValue);
    onTagFilterChange(selectedValue);
  }

  useEffect(() => {
    onTagFilterChange(selectedTag);
  }, [selectedTag, onTagFilterChange]);

  return (
    <Box
      sx={{
        display: "flex",
        alignItems: "baseline",
        flexDirection: "row",
        justifyContent: "flex-start",
        width: "100%",
        "@media (max-width: 425px)": {
          flexDirection: "column",
          alignItems: "flex-start"
        }
      }}
    >
      <Typography variant="subtitle1" sx={{ mr: 1, height: "35px" }}>
        Filter by Tag
      </Typography>
      <Select
        value={selectedTag}
        onChange={handleTagFilterChange}
        displayEmpty
        sx={{
          minWidth: 180,
          mt: 1,
          fontSize: "0.875rem",
          height: "35px",
          "@media (max-width: 425px)": {
            flexDirection: "column",
            alignItems: "flex-start",
            mt: -1
          }
        }}
      >
        <MenuItem value="all">All tags</MenuItem>
        <MenuItem value="untagged">Without tag</MenuItem>
        {sortedTags.map((tag) => (
          <MenuItem key={tag.idTag} value={String(tag.idTag)}>
            {tag.tagName}
          </MenuItem>
        ))}
      </Select>
    </Box>
  );
}
