VERSION >= v"0.4.0-dev+6521" && __precompile__(true)
module GLVisualize

using GLFW
using GLWindow
using GLAbstraction
using ModernGL
using FixedSizeArrays
using GeometryTypes
using ColorTypes
using Colors
using Reactive
using Quaternions
using Compat
using FixedPointNumbers
using FileIO
using Packing
using SignedDistanceFields
import Images

typealias GLBoundingBox AABB{Float32}

import Base: merge, convert, show


function assetpath(folders...)
    path = joinpath(dirname(@__FILE__), "..", "assets", folders...)
    isfile(path) || isdir(path) || error("Could not locate file at $path")
    path
end
loadasset(folders...) = load(assetpath(folders...))
export assetpath, loadasset

include("FreeTypeAbstraction.jl")

include("types.jl")
export CIRCLE, RECTANGLE, ROUNDED_RECTANGLE, DISTANCEFIELD, TRIANGLE

include("config.jl")
using .Config
import .Config: default

include("boundingbox.jl")

include("visualize_interface.jl")
export view #push renderobject into renderlist of the default screen, or supplied screen
export visualize    # Visualize an object
export visualize_default # get the default parameter for a visualization

include("utils.jl")
export y_partition
export x_partition
export loop, bounce
export clicked, dragged_on, is_hovering
export OR, AND, isnotempty

include("renderloop.jl")


include("texture_atlas.jl")
export Sprite
export GLSprite
export SpriteStyle
export GLSpriteStyle

include(joinpath("edit", "color_chooser.jl"))
include(joinpath("edit", "numbers.jl"))
include(joinpath("edit", "line_edit.jl"))
export vizzedit # edits some value, name should be changed in the future!

include(joinpath("visualize", "lines.jl"))
include(joinpath("visualize", "containers.jl"))
include(joinpath("visualize", "image_like.jl"))
include(joinpath("visualize", "mesh.jl"))
include(joinpath("visualize", "particles.jl"))
include(joinpath("visualize", "surface.jl"))
include(joinpath("visualize", "text.jl"))

include("camera.jl")
export cubecamera
include("compose_backend.jl")


Base.precompile(glscreen, ())


end # module
