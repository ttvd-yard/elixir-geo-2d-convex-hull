defmodule Geo2d.ConvexHull do

  @spec compute_points([Geo2d.point2]) :: [Geo2d.point2]
  def compute_points([]), do: []
  def compute_points([p]), do: [p]
  def compute_points([_p1, _p2] = p), do: p
  def compute_points(points) do
    sorted = Enum.sort(points, &sort_points/2)
    upper =
      sorted
      |> Enum.reduce([], &compute_half_hull/2)
      |> Enum.reverse
    lower =
      sorted
      |> Enum.reverse
      |> Enum.reduce([], &compute_half_hull/2)
      |> Enum.reverse
    [upper, lower] |> Enum.concat
  end

  @spec sort_points(Geo2d.point2, Geo2d.point2) :: boolean
  defp sort_points({x1, y1}, {x2, y2}) when x1 == x2, do: y1 < y2
  defp sort_points({x1, _y1}, {x2, _y2}), do: x1 < x2

  @spec cross(Geo2d.point2, Geo2d.point2, Geo2d.point2) :: float
  defp cross(p0, p1, p2) do
    v10 = Geo2d.Vector2.create(p0, p1)
    v20 = Geo2d.Vector2.create(p0, p2)
    Geo2d.Vector2.cross(v10, v20)
  end

  @spec compute_half_hull([Geo2d.point2], Geo2d.point2) :: [Geo2d.point2]
  defp compute_half_hull([], pn), do: [pn]
  defp compute_half_hull([p1], pn), do: [pn, p1]
  defp compute_half_hull([p2, p1 | p], pn) do
    if cross(p2, p1, pn) <= 0 do
      [p1 | p] |> compute_half_hull(pn)
    else
      [pn, p2, p1 | p]
    end
  end

end
